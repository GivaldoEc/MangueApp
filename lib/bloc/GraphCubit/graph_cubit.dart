import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'graph_state.dart';

class GraphCubit extends Cubit<GraphState> {
  GraphCubit() : super(GraphInitial());
}

List<List<dynamic>> data = [];

Future loadCsvReader() async {
  loadAsset() async {
    final myData = await rootBundle.loadString("assets/sensor_cvt.csv");
    List<List<dynamic>> csvTable = const CsvToListConverter().convert(myData);
    data = csvTable;
    print(data);
  }
}
