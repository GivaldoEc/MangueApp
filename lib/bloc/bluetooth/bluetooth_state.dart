part of 'bluetooth_bloc.dart';

@immutable
abstract class BluetoothState {}

class BluetoothInitial extends BluetoothState {} // first state

class BluetoothSearching extends BluetoothState {} // Searching

class BTUnconnectedState extends BluetoothState {} // Unconnected

class BTConnectedState extends BluetoothState {} // Connected and downloading
