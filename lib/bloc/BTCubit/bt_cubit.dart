import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

part 'bt_state.dart';

StreamController<List<int>> cont = StreamController<List<int>>.broadcast();

class BtCubit extends Cubit<BtState> {
  List<BluetoothDevice?> _deviceList = [];
  late BluetoothDevice _connectedDevice;

  //variáveis para o funcionamento do código
  final FlutterBlue flutterBlue = FlutterBlue.instance;
  late StreamSubscription btSubscription;
  Stream<List<int>> listStream = cont.stream;

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

    //Começa a procurar
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

  List<BluetoothDevice?> getDevices() {
    // device getter
    return _deviceList;
  }

  //Lista serviços constantemente
  Future discoverServices(BluetoothDevice device) async {
    emit(BtDonwloading(device: device));
    List<BluetoothService> services = await device.discoverServices();
    for (BluetoothService service in services) {
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        listStream = characteristic.value.asBroadcastStream();
        characteristic.setNotifyValue(!characteristic.isNotifying);
      }
    }
  }

  //Funções chave
  Future connectToDevice(BluetoothDevice device) async {
    await device.connect(
      autoConnect: false,
      timeout: const Duration(seconds: 7),
    );
    emit(BtConnected(device: device));
  }

  // Disconnects and resets bluetooth bloc
  Future<void> disconnectBt() async {
    await _connectedDevice.disconnect();
  }

  //Função para fechar as Streams
  @override
  Future<void> close() {
    btSubscription.cancel();
    return super.close();
  }
}
