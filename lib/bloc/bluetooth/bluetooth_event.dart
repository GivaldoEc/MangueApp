part of 'bluetooth_bloc.dart';

@immutable
abstract class BluetoothEvent {}

class BtSearchingEvent extends BluetoothEvent {} // Looking for bluetooth device

class BtDownloadingEvent extends BluetoothEvent {
} // Downloading data from vehicle

class BtDisconnectingEvent extends BluetoothEvent {
} // Disconnect from Bluetooth service