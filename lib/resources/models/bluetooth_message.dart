import 'acelerometer_data.dart';

const String tableMessages = 'messages';

class MessageFields {
  static final List<String> values = [
    id,
    accX,
    accY,
    accZ,
    dpsX,
    dpsY,
    dpsZ,
    rpm,
    speed,
    temperature,
    flags,
    timeStamp,
  ];

  static const String id = 'id';
  static const String accX = 'accx';
  static const String accY = 'accy';
  static const String accZ = 'accz';
  static const String dpsX = 'dpsx';
  static const String dpsY = 'dpsY';
  static const String dpsZ = 'dpsz';
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

  static BTMessage fromJson(Map<String, Object?> json) => BTMessage(
        id: json[MessageFields.id] as int?,
        rpm: json[MessageFields.rpm] as int,
        speed: json[MessageFields.speed] as int,
        temperature: json[MessageFields.temperature] as int,
        flags: json[MessageFields.flags] as int,
        timeStamp: json[MessageFields.timeStamp] as int,
        accelerometerData: AccelerometerData(
          accX: json[MessageFields.accX] as int,
          accY: json[MessageFields.accY] as int,
          accZ: json[MessageFields.accZ] as int,
          dpsX: json[MessageFields.dpsX] as int,
          dpsY: json[MessageFields.dpsX] as int,
          dpsZ: json[MessageFields.dpsZ] as int,
        ),
      );

  Map<String, Object?> toJson() => {
        // here you can execute conversions, to fit better the sql patterns
        MessageFields.id: id,
        MessageFields.accX: accelerometerData.accX,
        MessageFields.accY: accelerometerData.accY,
        MessageFields.accZ: accelerometerData.accZ,
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
