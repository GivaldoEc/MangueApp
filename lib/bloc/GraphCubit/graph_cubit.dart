import 'package:csv/csv.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'graph_state.dart';

class GraphCubit extends Cubit<GraphState> {
  GraphCubit() : super(GraphInitial());

  List<double> _data = [];

  List<FlSpot> _spotlist = [];
  List<FlSpot> getSpots() => _spotlist;

  // csv debug function

  void buildSpots() {
    List<FlSpot> spotlist = [];

    spotlist = [
      const FlSpot(20, 36.14),
      const FlSpot(900, 39.47),
      const FlSpot(1800, 42),
      const FlSpot(2900, 41),
      const FlSpot(3000, 20),
      const FlSpot(5000, 51.49),
      const FlSpot(7100, 59.53),
      const FlSpot(7200, 56.92),
    ];

    _spotlist = spotlist;
    emit(state);
  }
}
