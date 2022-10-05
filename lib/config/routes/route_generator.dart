import 'package:flutter/material.dart';
import 'package:mangueapp/presentation/bluetooth/bluetooth_screen.dart';
import 'package:mangueapp/presentation/config/theme_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Object? args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => const BluetoothScreen()); // First screen
      case '/THEME':
        return MaterialPageRoute(builder: (_)=>  const ThemeScreen());
      // TO DO: implement splashscreen
      default:
        return MaterialPageRoute(
            builder: (_) => const BluetoothScreen()); // return to init screen
    }
  }
}
