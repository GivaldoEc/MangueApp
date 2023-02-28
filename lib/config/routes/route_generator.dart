import 'package:flutter/material.dart';
import 'package:mangueapp/config/routes/routes.dart';
import 'package:mangueapp/presentation/bluetooth/bluetooth_screen.dart';
import 'package:mangueapp/presentation/config/config_screen.dart';
import 'package:mangueapp/presentation/gauge_screen/gauge_screen.dart';
import 'package:mangueapp/presentation/graphics/graphic_screen.dart';
import 'package:mangueapp/presentation/config/theme_screen.dart';
import 'package:mangueapp/presentation/mqtt_screen/mqtt_screen.dart';
import 'package:mangueapp/presentation/splash_screen/splash_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Object? args = settings.arguments;

    switch (settings.name) {
      case bluetoothRoute:
        return MaterialPageRoute(builder: (_) => const BluetoothWidget());

      case graphRoute:
        return MaterialPageRoute(builder: (_) => const GraphicScreen());
      case themeRoute:
        return MaterialPageRoute(builder: (_) => const ThemeScreen());
      case gaugeRoute:
        return MaterialPageRoute(builder: (_) => const GaugeScreen());
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case mqttRoute:
        return MaterialPageRoute(builder: (_) => MqttPage());
      default:
        return MaterialPageRoute(
            builder: (_) => const BluetoothWidget()); // return to init screen
    }
  }
}
