import 'package:flutter/material.dart';
import 'package:mangueapp/resources/widgets/navigation_bar.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GaugeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                        pointers: const <GaugePointer>[
                          RangePointer(
                            value: 0,
                            color: Colors.green,
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
                        pointers: const <GaugePointer>[
                          RangePointer(
                            value: 0,
                            color: Colors.green,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: SfLinearGauge(
                minimum: 0,
                maximum: 7,
                barPointers: const [
                  LinearBarPointer(
                    value: 0,
                    color: Colors.green,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: SfLinearGauge(
                barPointers: const [
                  LinearBarPointer(
                    value: 0,
                    color: Colors.green,
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
                        pointers: const <GaugePointer>[
                          RangePointer(
                            value: 0,
                            color: Colors.green,
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
        ),
      ),
      bottomNavigationBar: const MainNavigationBar(),
    );
  }
}
