import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangueapp/bloc/BTCubit/bt_cubit.dart';
import 'package:meta/meta.dart';

part 'app_mode_state.dart';

bool asyncMode = false;

class AppModeCubit extends Cubit<AppModeState> {
  AppModeCubit() : super(AppModeInitial()) {
    emit(AppModeSync());
  }

  void changeMode(context) {
    asyncMode = !asyncMode;
    BlocProvider.of<BtCubit>(context).changeMode(asyncMode);
    if (state is AppModeAsync) {
      emit(AppModeSync());
    } else {
      emit(AppModeAsync());
    }
  }
}
