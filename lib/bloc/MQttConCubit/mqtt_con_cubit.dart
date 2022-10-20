import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import '../../repositories/web/mqtt_config.dart';

part 'mqtt_con_state.dart';

class MqttConCubit extends Cubit<MqttConState> {
  MqttConCubit() : super(MqttConInitial());

  MqttClient client = MqttServerClient(mqttBroker, '');

// Connects to a broker
  void connect() async {
    //StreamSubscription subscription;

    emit(MqttConnecting());
    client.connectTimeoutPeriod = 2000;
    client.port = mqttPort;
    client.logging(on: true);
    client.keepAlivePeriod = 30;

    client.setProtocolV311();

    final MqttConnectMessage connMess = MqttConnectMessage()
        .withClientIdentifier(mqttUsername)
        .startClean() // Non persistent session for testing
        .withWillQos(MqttQos.atMostOnce);
    client.connectionMessage = connMess;

    try {
      print("started waiting");
      await client.connect();
      print("ended waiting");
    } on NoConnectionException catch (e) {
      // Raised by the client when connection fails.
      client.disconnect();
    } on SocketException catch (e) {
      // Raised by the socket layer
      client.disconnect();
    }
    if (client.connectionState == MqttConnectionState.connected) {
      emit(MqttConnected());
    } else {
      emit(MqttDisconnected());
    }
  }

  void _subscribeToTopic(String topic) {
    if (client.connectionState == MqttConnectionState.connected) {
      client.subscribe(topic, MqttQos.exactlyOnce);
    }
  }

  void publish() {
    print("connected attempt");
    final builder = MqttClientPayloadBuilder();
    builder.addString('Hello from mqtt_client');
    print('EXAMPLE::Subscribing to the Dart/Mqtt_client/testtopic topic');
    client.subscribe(mqtTopic, MqttQos.exactlyOnce);
  }
}
