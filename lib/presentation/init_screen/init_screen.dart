import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangueapp/bloc/bluetooth/bluetooth_bloc.dart';

class BluetoothScreen extends StatelessWidget {
  const BluetoothScreen({super.key});
  final String appTitle = "Bluetooth App";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
      ),
      body: Center(
        child: BlocBuilder<BluetoothBloc, BluetoothState>(
          builder: (context, state) {
            return ListView(
              padding: const EdgeInsets.all(8),
              children: [],
            );
          },
        ),
      ),
    );
  }
}
