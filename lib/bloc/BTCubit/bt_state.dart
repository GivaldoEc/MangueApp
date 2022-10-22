part of 'bt_cubit.dart';

@immutable
abstract class BtState {}

class BtInitial extends BtState {} // Initial state

class BtOFF extends BtState {} // Bluetooth not eneabled

class BtDisconnected extends BtState {
  final List<BluetoothDevice?> deviceList;

  BtDisconnected({
    required this.deviceList,
  });
} // Bluetooth turned on, but no device connected

class BtSearching extends BtState {} // Looking for devices

class BtConnected extends BtState {
  final BluetoothDevice device;

  BtConnected({
    required this.device,
  }); // Bluetooth connected
}

class BtDonwloading extends BtState {
  final BluetoothDevice device;

  BtDonwloading({
    required this.device,
  });
} // Receiving data

class BtNothingFound extends BtState {} // No device found

class BtSync extends BtState {} // BtSynchronized
