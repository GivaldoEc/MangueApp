import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangueapp/bloc/BTCubit/bt_cubit.dart';
import 'package:mangueapp/bloc/MQttConCubit/mqtt_con_cubit.dart';
import 'package:mangueapp/config/routes/routes.dart';
import 'package:mangueapp/repositories/models/bt_sync.dart';
import 'package:mangueapp/resources/widgets/navigation_bar.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GaugeScreen extends StatelessWidget {
  const GaugeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BtCubit btCubit = BlocProvider.of<BtCubit>(context);

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<BtCubit, BtState>(
          builder: (context, state) {
            if (state is BtSync) {
              return StreamBuilder<List<int>>(
                  stream: btCubit.listStream,
                  initialData: const [],
                  builder: (context, snapshot) {
                    Uint8List list = Uint8List.fromList(snapshot.data!);
                    ByteData byteData = ByteData.view(list.buffer);

                    double speed = 0;
                    double rpm = 0;
                    double temp = 0;

                    // streammed variables
                    if (snapshot.hasData && snapshot.data![0] != 0) {
                      speed = (byteData.getUint16(15) * 60 / 65535);
                      rpm = (byteData.getUint16(13) * 5000 / 65535);
                      temp = (byteData.getUint8(17) / 1);

                      BlocProvider.of<MqttConCubit>(context).snapShotPacket =
                          BluetootSyncPack(
                        speed: speed,
                        rpm: rpm,
                        oilTemp: temp,
                      );
                    }
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
                                axes: <RadialAxis>[
                                  RadialAxis(
                                    pointers: <GaugePointer>[
                                      RangePointer(
                                        value: speed,
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
                                        value: rpm,
                                        color: Colors.black,
                                      )
                                    ],
                                    minimum: 0,
                                    maximum: 4000,
                                    ranges: [
                                      GaugeRange(
                                        startValue: 3000,
                                        endValue: 4000,
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
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
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
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
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
                                        value: temp,
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
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: MainNavigationBar(),
      body: Center(child: Text("doidera")),
    );
  }
}
