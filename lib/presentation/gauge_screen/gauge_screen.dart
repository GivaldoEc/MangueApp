import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangueapp/bloc/BTCubit/bt_cubit.dart';
import 'package:mangueapp/bloc/MQttConCubit/mqtt_con_cubit.dart';
import 'package:mangueapp/repositories/models/bt_sync.dart';
import 'package:mangueapp/resources/widgets/navigation_bar.dart';
import 'package:mangueapp/resources/widgets/progress_indicator.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GaugeScreen extends StatelessWidget {
  const GaugeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BtCubit btCubit = BlocProvider.of<BtCubit>(context);
    BluetootSyncPack mqttPack =
        BlocProvider.of<MqttConCubit>(context).snapShotPacket;

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<BtCubit, BtState>(
          builder: (context, state) {
            if (state is BtSync) {
              return StreamBuilder<List<int>>(
                  stream: btCubit.listStream,
                  initialData: const [],
                  builder: (context, snapshot) {
                    // TODO: HardCoded chunck of code... Fix it!
                    if (snapshot.connectionState == ConnectionState.active) {
                      // streammed variables
                      // if (snapshot.hasData && snapshot.data![0] != 0) {
                      Uint8List list = Uint8List.fromList(snapshot.data!);
                      ByteData byteData = ByteData.view(list.buffer, 1, 11);
                      // print(snapshot.data!.length); // remember to keep packet size in mind, always
                      // const int offset = 0;
                      mqttPack.rpm = (byteData.getUint16(0) * 12156 / 65535);
                      mqttPack.speed = (byteData.getUint16(2) * 76 / 65535);
                      mqttPack.oilTemp = (byteData.getUint8(4) * 139 / 256);
                      mqttPack.cvt = (byteData.getUint8(5) * 95 / 256);
                      mqttPack.battery = (byteData.getUint8(6) * 257 / 256);
                      mqttPack.soc = (byteData.getUint8(7) * 856 / 256);
                      // accX = (byteData.getInt16(8) * 257 / 65535);
                      // accY = (byteData.getInt16(10) * 257 / 65535);
                      // accZ = (byteData.getInt16(12) * 257 / 65535);
                      // dpsX = (byteData.getInt16(14) * 257 / 65535);
                      // dpsX = (byteData.getInt16(16) * 257 / 65535);
                      // dpsZ = (byteData.getInt16(18) * 257 / 65535);
                      mqttPack.latitude = (byteData.getInt8(8) * 257 / 256);
                      mqttPack.longitude = (byteData.getInt8(9) * -75 / 256);
                      // timeStamp = (byteData.getUint32(22) * 1000 / 4294967295);
                      BlocProvider.of<MqttConCubit>(context).publish(
                          context); // TODO: find a better implementation

                      print(
                          "${mqttPack.rpm}, ${mqttPack.speed}, ${mqttPack.oilTemp}, ${mqttPack.cvt}, ${mqttPack.battery}, ${mqttPack.soc}, ${mqttPack.latitude}, ${mqttPack.longitude}");

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
                                          value: mqttPack.speed,
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
                                          value: mqttPack.rpm,
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
                              barPointers: const [
                                LinearBarPointer(
                                  value: 0,
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
                              barPointers: const [
                                LinearBarPointer(
                                  value: 0,
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
                                          value: mqttPack.oilTemp,
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
                                          value: mqttPack.cvt,
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
              return const Center(
                  child: Text(
                "Bluetooth Connection Required!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 35,
                ),
              ));
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
