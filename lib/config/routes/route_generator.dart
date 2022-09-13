import 'package:flutter/material.dart';
import 'package:mangueapp/presentation/init_screen/init_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Object? args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => const BluetoothScreen()); // First screen
      // TO DO: implement splashscreen
      default:
        return MaterialPageRoute(
            builder: (_) => const BluetoothScreen()); // return to init screen
    }
  }
}
