import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangueapp/bloc/GraphCubit/graph_cubit.dart';
import 'package:mangueapp/resources/widgets/navigation_bar.dart';
import 'package:mangueapp/resources/widgets/option_widget.dart';

class GraphicScreen extends StatelessWidget {
  const GraphicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GraphCubit cubit = BlocProvider.of<GraphCubit>(context);

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const MainNavigationBar(),
        body: Center(
            child: Column(
          children: [
            Expanded(
              child: BlocBuilder<GraphCubit, GraphState>(
                builder: (context, state) {
                  return LineChart(
                    LineChartData(
                      maxY: 70,
                      minY: 20,
                      minX: 0,
                      maxX: 7400,
                      lineBarsData: [
                        LineChartBarData(
                          spots: cubit.getSpots(),
                          isCurved: true,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: InkWell(
                child: const BLuetoothContainer(text: "Fecth data"),
                onTap: () {
                  BlocProvider.of<GraphCubit>(context).buildSpots();
                },
              ),
            )
          ],
        )),
      ),
    );
  }
}
