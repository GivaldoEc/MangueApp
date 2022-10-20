part of 'mqtt_con_cubit.dart';

@immutable
abstract class MqttConState {}

class MqttConInitial extends MqttConState {}

class MqttDisconnected extends MqttConState {}

class MqttConnected extends MqttConState {}

class MqttConnecting extends MqttConState {}
