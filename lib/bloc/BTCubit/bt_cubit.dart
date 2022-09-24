import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

part 'bt_state.dart';

StreamController<List<int>> cont = StreamController<List<int>>.broadcast();

class BtCubit extends Cubit<BtState> {
  bool connected = false;
  List<BluetoothDevice?> _deviceList = [];

  //variáveis para o funcionamento do código
  final FlutterBlue flutterBlue = FlutterBlue.instance;
  late StreamSubscription btSubscription;
  late BluetoothDevice devv;
  Stream<List<int>> listStream = cont.stream;

  //Emite estados do bloc com base no bluetooth
  BtCubit() : super(BtInitial()) {
    btSubscription = flutterBlue.state.listen((btState) {
      if (btState == BluetoothState.off) {
        emit(
          BtOFF(),
        );
      } else if (btState == BluetoothState.on && !connected) {
        emit(
          BtDisconnected(),
        );
      }
    });
  }

  //lista dispositivos
  Future<List<BluetoothDevice>> lookForDevices() async {
    List<BluetoothDevice> devices = [];

    flutterBlue.startScan(timeout: const Duration(seconds: 5));

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
      print(devices);
      _deviceList = devices;
      return devices;
    } else {
      return [];
    }
  }

  List<BluetoothDevice?> getDevices() {
    // device getter
    return _deviceList;
  }

  void situationalCaller(List list) {
    if (list.isEmpty) {
      emit(BtNothingFound());
    } else {
      emit(BtFound());
    }
  }

  //Lista serviços constantemente

  Future discoverServices(BluetoothDevice device, bool isready) async {
    List<BluetoothService> services = await device.discoverServices();
    services.forEach((service) {
      service.characteristics.forEach((characteristic) {
        listStream = characteristic.value.asBroadcastStream();
        characteristic.setNotifyValue(!characteristic.isNotifying);
        isready = true;
      });
    });
  }

  //Funções chave
  Future connectToDevice(
      BluetoothDevice device, bool isconn, bool isready) async {
    await device.connect(autoConnect: false);
    isconn = true;
    connected = isconn;
    devv = device;
    emit(BtConnected(device: device, listStream: listStream));
  }

  //disconecta e reinicia o cubit
  Future<void> disconnectBt(bool connectionStateBool) async {
    await devv.disconnect();
    connectionStateBool = false;
  }

  //tenta novamente
  void retry() {
    emit(BtDisconnected());
  }

  void notFound() {
    emit(BtNothingFound());
    return;
  }

  //Função para fechar as Streams
  @override
  Future<void> close() {
    btSubscription.cancel();
    return super.close();
  }
}
