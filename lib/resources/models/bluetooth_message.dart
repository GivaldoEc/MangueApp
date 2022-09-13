import 'acelerometer_data.dart';

const String tableMessages = 'messages';

class MessageFields {
  static const String id = 'id';
  static const String accelerometerData = 'accelerometer';
  static const String rpm = 'rpm';
  static const String speed = 'speed';
  static const String temperature = 'temperature';
  static const String flags = 'flags';
  static const String timeStamp = 'timeStamp';
}

class BTMessage {
  final int? id;
  final AccelerometerData accelerometerData;
  final int rpm;
  final int speed;
  final int temperature;
  final int flags;
  final int timeStamp;

  BTMessage({
    this.id,
    required this.accelerometerData,
    required this.rpm,
    required this.speed,
    required this.temperature,
    required this.flags,
    required this.timeStamp,
  });

  Map<String, Object?> toJson() => {
        // here you can execute conversions, to fit better the sql patterns
        MessageFields.id: id,
        MessageFields.accelerometerData: // TO DO: fix it!
            accelerometerData, // probably not gonna work
        MessageFields.rpm: rpm,
        MessageFields.temperature: temperature,
        MessageFields.flags: flags,
        MessageFields.timeStamp: timeStamp,
      };

  BTMessage copy({
    final int? id,
    final AccelerometerData? accelerometerData,
    final int? rpm,
    final int? speed,
    final int? temperature,
    final int? flags,
    final int? timeStamp,
  }) =>
      BTMessage(
        id: id ?? this.id,
        accelerometerData: accelerometerData ?? this.accelerometerData,
        rpm: rpm ?? this.rpm,
        speed: speed ?? this.speed,
        temperature: temperature ?? this.temperature,
        flags: flags ?? this.flags,
        timeStamp: timeStamp ?? this.timeStamp,
      );
}
