import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangueapp/bloc/BTCubit/bt_cubit.dart';
import 'package:mangueapp/repositories/models/bt_sync.dart';
import 'package:meta/meta.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import '../../repositories/web/mqtt_config.dart';

part 'mqtt_con_state.dart';

MqttClient client = MqttServerClient.withPort(mqttBroker, '', 1883);

class MqttConCubit extends Cubit<MqttConState> {
  MqttConCubit() : super(MqttConInitial()) {
    connect();
  }

  BluetootSyncPack snapShotPacket = BluetootSyncPack();

// Connects to a broker
  void connect() async {
    client.logging(on: true);

    //StreamSubscription subscription;
    emit(MqttConnecting());

    client.setProtocolV311();
    client.keepAlivePeriod = 60;
    client.connectTimeoutPeriod = 2000;
    client.port = mqttPort;

    client.websocketProtocols = MqttClientConstants.protocolsMultipleDefault;

    // final MqttConnectMessage connMess = MqttConnectMessage()
    //     .withClientIdentifier(mqttUsername)
    //     .startClean() // Non persistent session for testing
    //     .withWillQos(MqttQos.atMostOnce);
    // client.connectionMessage = connMess;

    try {
      await client.connect(mqttUsername, mqttPassword);
    } on NoConnectionException catch (_) {
      client.disconnect();
    } on SocketException catch (_) {
      client.disconnect();
    }
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      emit(MqttConnected());
    } else {
      emit(MqttDisconnected());
    }
  }

  void publish(context) {
    if (state is MqttConnected) {
      final builder = MqttClientPayloadBuilder();
      builder.addString({
        "\"car\"": 22,
        "\"accx\"": 0,
        "\"accy\"": 0,
        "\"accz\"": 0,
        "\"rpm\"": snapShotPacket.rpm,
        "\"speed\"": snapShotPacket.speed,
        "\"temp\"": snapShotPacket.oilTemp,
        "\"flags\"": 0,
        "\"soc\"": snapShotPacket.soc,
        "\"cvt\"": snapShotPacket.cvt,
        "\"volt\"": snapShotPacket.battery,
        "\"latitude\"": snapShotPacket.latitude,
        "\"longitude\"": snapShotPacket.longitude,
        "\"timeStamp\"": snapShotPacket.timeStamp,

        // "\"fuel\"": snapShotPacket.fuel,
      }.toString());

      client.publishMessage(mqtPubTopic, MqttQos.atLeastOnce, builder.payload!);
    } else {
      return;
    }
  }

  void disconnect() {
    client.disconnect();
    emit(MqttDisconnected());
  }
}
