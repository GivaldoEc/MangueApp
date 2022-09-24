import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangueapp/bloc/BTCubit/bt_cubit.dart';
import 'package:mangueapp/resources/widgets/bluetooth_list.dart';
import 'package:mangueapp/resources/widgets/option_widget.dart';

class BluetoothScreen extends StatelessWidget {
  final String appTitle = "Bluetooth App";


  const BluetoothScreen({super.key});

  @override
  Widget build(BuildContext context) {
      BtCubit btCubit = BlocProvider.of<BtCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
      ),
      body: Center(
        child: BlocBuilder<BtCubit, BtState>(
          builder: (context, state) {
            return const Center(child: BluetoothList());
          },
        ),
      ),
    );
  }
}
