import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

part 'bt_state.dart';

StreamController<List<int>> cont = StreamController<List<int>>.broadcast();

class BtCubit extends Cubit<BtState> {
  bool _asyncMode = false;

  void changeMode(asyncMode) {
    _asyncMode = asyncMode;
    return;
  }

  // current info
  late BluetoothDevice? _connectedDevice;

  List<BluetoothCharacteristic> _characteristics = [];
  List<BluetoothDevice?> _deviceList = [];
  List<List<int>> _characteristicData = [];

  //variáveis para o funcionamento do código
  final FlutterBlue flutterBlue = FlutterBlue.instance;
  late StreamSubscription btSubscription;

  //Emite estados do bloc com base no bluetooth
  BtCubit() : super(BtInitial()) {
    btSubscription = flutterBlue.state.listen((btState) {
      if (btState == BluetoothState.off) {
        emit(
          BtOFF(),
        );
      } else if (btState == BluetoothState.on) {
        emit(
          BtDisconnected(deviceList: const []),
        );
      }
    });
  }

  // look for devices
  Future<List<BluetoothDevice>> lookForDevices() async {
    List<BluetoothDevice> devices = [];

    flutterBlue.startScan(timeout: const Duration(seconds: 5));

    emit(BtSearching());

    // Starts looking
    btSubscription = flutterBlue.scanResults.listen(
      (results) {
        for (ScanResult r in results) {
          if (!devices.contains(r.device)) {
            devices.add(r.device);
          }
        }
      },
    );
    await Future.delayed(const Duration(seconds: 5));
    //Para de procurar
    flutterBlue.stopScan();

    if (devices.isNotEmpty) {
      _deviceList = devices;
      emit(BtDisconnected(deviceList: devices));
      return devices;
    } else {
      _deviceList = [];
      emit(BtNothingFound());
      return [];
    }
  }

  List<List<int>> getCharacteristicData() => _characteristicData;

  BluetoothDevice? getDevice() => _connectedDevice;

  List<BluetoothCharacteristic> getCharacteristics() => _characteristics;

  List<BluetoothDevice?> getDevices() => _deviceList;

  Future scanCharacteristics() async {
    _characteristics = [];
    _characteristicData = [];
    emit(BtDonwloading(device: _connectedDevice!));
    List<BluetoothService> services =
        await _connectedDevice!.discoverServices();
    Future.delayed(const Duration(seconds: 5), () {
      emit(BtConnected(device: _connectedDevice!));
      return;
    });
    for (BluetoothService service in services) {
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        _characteristics.add(characteristic);
        _characteristicData.add(await characteristic.read());
      }
    }
  }

  Future sendOpenRequisition(BluetoothCharacteristic receptor) async {
    emit(BtDonwloading(device: _connectedDevice!));
    Future.delayed(const Duration(seconds: 3), () {
      scanCharacteristics(); // just for debug purpouse
      return;
    });
    print("trying to send");
    await receptor.write([1]);
    print("sent");
  }

  Future sendClosingRequisition(BluetoothCharacteristic receptor) async {
    await receptor.write([0]);
    return;
  }

  // Key functions
  Future connectToDevice(BluetoothDevice device) async {
    await device.connect(
      autoConnect: false,
      timeout: const Duration(seconds: 7),
    );
    List<BluetoothDevice> connectedDevices = await flutterBlue.connectedDevices;
    if (connectedDevices.contains(device)) {
      _connectedDevice = device;
      emit(BtConnected(device: device));
      scanCharacteristics();
      return;
    }
    _connectedDevice = null;
    emit(BtDisconnected(deviceList: _deviceList));
    return;
  }

  // Disconnects and resets bluetooth bloc
  Future<void> disconnectBt() async {
    await _connectedDevice!.disconnect();
    _connectedDevice = null;
    _characteristicData = [];
    _characteristics = [];
    emit(BtDisconnected(deviceList: const []));
  }

  // Closing Stream function
  @override
  Future<void> close() {
    btSubscription.cancel();
    return super.close();
  }
}
