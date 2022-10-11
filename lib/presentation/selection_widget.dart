import 'package:flutter/material.dart';
import 'package:mangueapp/presentation/bluetooth/bluetooth_screen.dart';
import 'package:mangueapp/resources/widgets/navigation_bar.dart';

class SelectionScreen extends StatelessWidget {
  final String appTitle = "Bluetooth App";

  const SelectionScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: // Bottom navigation style
        MainNavigationBar(),
      body: BluetoothWidget(),
    );
  }
}
