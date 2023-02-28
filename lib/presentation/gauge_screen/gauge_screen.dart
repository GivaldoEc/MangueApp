import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangueapp/bloc/MQttConCubit/mqtt_con_cubit.dart';
import 'package:mangueapp/repositories/models/bt_sync.dart';
import 'package:mangueapp/resources/widgets/navigation_bar.dart';
import 'package:mangueapp/resources/widgets/progress_indicator.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GaugeScreen extends StatelessWidget {
  const GaugeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MqttConCubit conCubit = BlocProvider.of<MqttConCubit>(context);
    BluetootSyncPack mqttPack = conCubit.snapShotPacket;

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<MqttConCubit, MqttConState>(
          builder: (context, state) {
            if (state is MqttConnected) {
              return StreamBuilder<List<MqttReceivedMessage<MqttMessage>>>(
                  stream: conCubit.getMessagesStream(),
                  initialData: const [],
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      final recMess =
                          snapshot.data![0].payload as MqttPublishMessage;
                      final pt = MqttPublishPayload.bytesToStringAsString(
                          recMess.payload.message);

                      Map<String, dynamic> map = jsonDecode(pt);

                      mqttPack.rpm = (map["rpm"]/65535)*5000;
                      mqttPack.speed = (map["speed"]/65535)*60;
                      mqttPack.oilTemp = map["motor"];
                      mqttPack.soc = map["soc"];
                      mqttPack.battery = map["volt"];
                      mqttPack.cvt = map["cvt"];
                      //mqttPack.fuel = map["fuel"]; --> replace

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              // Speed
                              SizedBox(
                                width: 200,
                                height: 200,
                                child: SfRadialGauge(
                                  animationDuration: 0,
                                  enableLoadingAnimation: false,
                                  axes: <RadialAxis>[
                                    RadialAxis(
                                      pointers: <GaugePointer>[
                                        RangePointer(
                                          value: mqttPack.speed.toDouble(),
                                          color: Colors.black,
                                        )
                                      ],
                                      minimum: 0,
                                      maximum: 60,
                                      ranges: [
                                        GaugeRange(
                                          startValue: 0,
                                          endValue: 60,
                                          color: Colors.white10,
                                        ),
                                      ],
                                    )
                                  ],
                                  title: const GaugeTitle(
                                      text: "Speed",
                                      textStyle: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 20,
                                      )),
                                ),
                              ),
                              // RPM
                              SizedBox(
                                width: 200,
                                height: 200,
                                child: SfRadialGauge(
                                  axes: <RadialAxis>[
                                    RadialAxis(
                                      pointers: <GaugePointer>[
                                        RangePointer(
                                          value: mqttPack.rpm.toDouble(),
                                          color: Colors.black,
                                        )
                                      ],
                                      minimum: 0,
                                      maximum: 5000,
                                      ranges: [
                                        GaugeRange(
                                          startValue: 3500,
                                          endValue: 5000,
                                          color: Colors.red,
                                        ),
                                      ],
                                    )
                                  ],
                                  title: const GaugeTitle(
                                      text: "RPM",
                                      textStyle: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 20,
                                      )),
                                ),
                              ),
                            ],
                          ),
                          // Fuel
                          const Text(
                            "Fuel",
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 20,
                            ),
                          ),
                          // Fuel
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 40.0),
                            child: SfLinearGauge(
                              ranges: const [
                                LinearGaugeRange(
                                  startValue: 0,
                                  endValue: 1,
                                  color: Colors.red,
                                ),
                              ],
                              minimum: 0,
                              maximum: 7,
                              barPointers: [
                                LinearBarPointer(
                                  value: mqttPack.fuel.toDouble(),
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                          const Text(
                            "Battery",
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 20,
                            ),
                          ),
                          // Battery
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 40.0),
                            child: SfLinearGauge(
                              ranges: const [
                                LinearGaugeRange(
                                  startValue: 0,
                                  endValue: 20,
                                  color: Colors.red,
                                ),
                              ],
                              barPointers: [
                                LinearBarPointer(
                                  value: mqttPack.soc.toDouble(),
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              // Temp do óleo
                              SizedBox(
                                width: 200,
                                height: 200,
                                child: SfRadialGauge(
                                  axes: <RadialAxis>[
                                    RadialAxis(
                                      pointers: <GaugePointer>[
                                        RangePointer(
                                          value: mqttPack.oilTemp.toDouble(),
                                          color: Colors.black,
                                        )
                                      ],
                                      minimum: 0,
                                      maximum: 140,
                                      ranges: [
                                        GaugeRange(
                                          startValue: 0,
                                          endValue: 103,
                                          color: Colors.white10,
                                        ),
                                        GaugeRange(
                                          startValue: 103,
                                          endValue: 140,
                                          color: Colors.red,
                                        ),
                                      ],
                                    )
                                  ],
                                  title: const GaugeTitle(
                                      text: "Oil Temperature",
                                      textStyle: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 20,
                                      )),
                                ),
                              ),
                              // Temp Da CVT
                              SizedBox(
                                width: 200,
                                height: 200,
                                child: SfRadialGauge(
                                  axes: <RadialAxis>[
                                    RadialAxis(
                                      pointers: <GaugePointer>[
                                        RangePointer(
                                          value: mqttPack.cvt.toDouble(),
                                          color: Colors.black,
                                        )
                                      ],
                                      minimum: 0,
                                      maximum: 100,
                                      ranges: [
                                        GaugeRange(
                                          startValue: 0,
                                          endValue: 72,
                                          color: Colors.white10,
                                        ),
                                        GaugeRange(
                                          startValue: 72,
                                          endValue: 100,
                                          color: Colors.red,
                                        ),
                                      ],
                                    )
                                  ],
                                  title: const GaugeTitle(
                                      text: "CVT temperature",
                                      textStyle: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 20,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    } else {
                      return Center(child: AppProgressIndicator());
                    }
                  });
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppProgressIndicator(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      child: ElevatedButton(
                        onPressed: () {
                          conCubit.connect();
                        },
                        child: const Text("Retry Connection"),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
      bottomNavigationBar: const MainNavigationBar(),
    );
  }
}

class GaugeSelector extends StatelessWidget {
  const GaugeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: MainNavigationBar(),
      body: Center(child: Text("doidera")),
    );
  }
}
