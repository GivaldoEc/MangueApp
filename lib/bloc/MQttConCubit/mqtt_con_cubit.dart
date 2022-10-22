import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import '../../repositories/web/mqtt_config.dart';

part 'mqtt_con_state.dart';

MqttClient client = MqttServerClient.withPort(mqttBroker, '', 1883);

class MqttConCubit extends Cubit<MqttConState> {
  MqttConCubit() : super(MqttConInitial());

// Connects to a broker
  void connect() async {
    print(mqttBroker);

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
      print("started waiting");
      await client.connect(mqttUsername, mqttPassword);
      print("ended waiting");
    } on NoConnectionException catch (e) {
      print('MQTT client exception - $e');
      client.disconnect();
    } on SocketException catch (e) {
      print('MQTT client exception - $e');
      client.disconnect();
    }
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      emit(MqttConnected());
    } else {
      emit(MqttDisconnected());
    }
  }

  void _subscribeToTopic(String topic) {
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      //client.subscribe(topic, MqttQos.exactlyOnce);
    }
  }

  void publish() {
    print("connected attempt");
    final builder = MqttClientPayloadBuilder();
    builder.addString('Hello from mqtt_client');
    print('EXAMPLE::Subscribing to the Dart/Mqtt_client/testtopic topic');
    client.subscribe(mqtPubTopic, MqttQos.exactlyOnce);
  }
}
