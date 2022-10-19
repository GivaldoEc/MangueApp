import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mqtt_client/mqtt_client.dart';

import '../../repositories/web/mqtt_config.dart';

part 'connection_state.dart';

class ConnectionCubit extends Cubit<ConnectionState> {
  ConnectionCubit() : super(ConnectionInitial()) {
    _connect();
  }

  MqttClient client = MqttClient(mqttBroker, '');

  // Connects to a broker
  void _connect() async {
    //StreamSubscription subscription;

    client.port = mqttPort;
    client.logging(on: true);
    client.keepAlivePeriod = 30;

    final MqttConnectMessage connMess = MqttConnectMessage()
        .withClientIdentifier(mqttUsername)
        .startClean() // Non persistent session for testing
        .withWillQos(MqttQos.atMostOnce);
    client.connectionMessage = connMess;
    try {
      await client.connect();
    } on NoConnectionException catch (e) {
      // Raised by the client when connection fails.
      print('EXAMPLE::client exception - $e');
      client.disconnect();
    } on SocketException catch (e) {
      // Raised by the socket layer
      print('EXAMPLE::socket exception - $e');
      client.disconnect();
    }
    if (client.connectionState == MqttConnectionState.connected) {
      emit(ConnectionConnected());
    } else {
      emit(ConnectionDisconnected());
    }
  }

  void _subscribeToTopic(String topic) {
    if (client.connectionState == MqttConnectionState.connected) {
      client.subscribe(topic, MqttQos.exactlyOnce);
    }
  }

  void publish() {
    final builder = MqttClientPayloadBuilder();
    builder.addString('Hello from mqtt_client');
    print('EXAMPLE::Subscribing to the Dart/Mqtt_client/testtopic topic');
  client.subscribe(mqtTopic, MqttQos.exactlyOnce);
  }
}
