part of 'graph_cubit.dart';

@immutable
abstract class GraphState {}

class GraphInitial extends GraphState {}

class GraphLoadingData extends GraphState {}

class GraphExposition extends GraphState {}