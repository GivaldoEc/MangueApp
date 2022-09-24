part of 'bt_cubit.dart';

@immutable
abstract class BtState {}

class BtInitial extends BtState {} //estado inicial

class BtOFF extends BtState {} //estado para bluetooth desligado

class BtDisconnected extends BtState {} //bluetooth ligado, mas não conectado

class BtConnected extends BtState {
  final BluetoothDevice device;
  final Stream<List<int>>? listStream;

  BtConnected(
      {required this.device,
      required this.listStream}); //bluetooth ligado e conectado
}

class BtFound extends BtState {
} //estado intermediário. Ligado mas não conectado

class BtNothingFound extends BtState {}
