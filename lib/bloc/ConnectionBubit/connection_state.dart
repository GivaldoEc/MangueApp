part of 'connection_cubit.dart';

@immutable
abstract class ConnectionState {}

class ConnectionInitial extends ConnectionState {}

class ConnectionDisconnected extends ConnectionState{}

class ConnectionConnecting extends ConnectionState {}

class ConnectionConnected extends ConnectionState {}