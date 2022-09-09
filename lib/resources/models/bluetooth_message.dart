import 'package:flutter/foundation.dart';

import 'acelerometer_data.dart';

const String tableMessages = 'messages';

class MessageFields {
  static const String rpm = 'rpm';
  static const String speed = 'speed';
  static const String temperature = 'temperature';
  static const String flags = 'flags';
  static const String timeStamp = 'timeStamp';
}

class BTMessage {
  final AcelerometerData acelerometerData;
  final int rpm;
  final int speed;
  final int temperature;
  final int flags;
  final int timeStamp;

  BTMessage({
    required this.acelerometerData,
    required this.rpm,
    required this.speed,
    required this.temperature,
    required this.flags,
    required this.timeStamp,
  });
}
