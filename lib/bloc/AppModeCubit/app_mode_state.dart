part of 'app_mode_cubit.dart';

@immutable
abstract class AppModeState {}

class AppModeInitial extends AppModeState {}

class AppModeAsync extends AppModeState {}

class AppModeSync extends AppModeState {}