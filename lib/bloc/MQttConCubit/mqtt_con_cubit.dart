import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangueapp/bloc/BTCubit/bt_cubit.dart';
import 'package:mangueapp/repositories/models/bt_sync.dart';
import 'package:meta/meta.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import '../../repositories/web/mqtt_config.dart';

part 'mqtt_con_state.dart';

MqttClient client = MqttServerClient.withPort(mqttBroker, '', 1883);

StreamController<String> cont = StreamController<String>.broadcast();

class MqttConCubit extends Cubit<MqttConState> {
  Stream<String> listStream = cont.stream;

  MqttConCubit() : super(MqttConInitial()) {
    connect();
  }

  BluetootSyncPack snapShotPacket = BluetootSyncPack();

  Future subscribeToTopic() async {
    client.subscribe(mqttSubTopic, MqttQos.atMostOnce);
  }

  Stream<List<MqttReceivedMessage<MqttMessage>>>? getMessagesStream() {
    return client.updates;
  }

void setupUpdatesListener() {
    getMessagesStream()!
        .listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      print('MQTTClient::Message received on topic: <${c[0].topic}> is $pt\n');
    });
  }



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
      subscribeToTopic();
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
