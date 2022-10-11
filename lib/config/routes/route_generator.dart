import 'package:flutter/material.dart';
import 'package:mangueapp/config/routes/routes.dart';
import 'package:mangueapp/presentation/bluetooth/bluetooth_screen.dart';
import 'package:mangueapp/presentation/config/config_screen.dart';
import 'package:mangueapp/presentation/graphics/graphic_screen.dart';
import 'package:mangueapp/presentation/selection_widget.dart';
import 'package:mangueapp/presentation/config/theme_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Object? args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => const SelectionScreen()); // First screen
      case bluetoothRoute:
        return MaterialPageRoute(builder: (_) => const BluetoothWidget());
      case configRoute:
        return MaterialPageRoute(builder: (_) => const ConfigScreen());
      case graphRoute:
        return MaterialPageRoute(builder: (_) => GraphicScreen());
        case themeRoute:
        return MaterialPageRoute(builder: (_) => const ThemeScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => const SelectionScreen()); // return to init screen
    }
  }
}
