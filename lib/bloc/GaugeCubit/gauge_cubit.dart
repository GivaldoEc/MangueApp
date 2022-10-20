import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'gauge_state.dart';

class GaugeCubit extends Cubit<GaugeState> {
  GaugeCubit() : super(GaugeInitial());
}
