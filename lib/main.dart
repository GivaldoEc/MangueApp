import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangueapp/bloc/BTCubit/bt_cubit.dart';
import 'package:mangueapp/bloc/GraphCubit/graph_cubit.dart';
import 'package:mangueapp/config/routes/route_generator.dart';
import 'package:mangueapp/config/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) =>
              BtCubit(), // bluetooth bloc provider
        ),
        BlocProvider(
          create: (BuildContext context) => GraphCubit(),
        )
      ], 
      child: MaterialApp(
        title: 'MangueApp',
        theme: ThemeData(
          primarySwatch: Colors.blue, // TODO: implement cubit
        ),
        initialRoute: init,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
