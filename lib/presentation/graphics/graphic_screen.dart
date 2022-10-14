import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mangueapp/resources/widgets/navigation_bar.dart';

class GraphicScreen extends StatelessWidget {
  const GraphicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const MainNavigationBar(
        ),
        body: Center(child: LineChart(LineChartData())),
      ),
    );
  }
}
