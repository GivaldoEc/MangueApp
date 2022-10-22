import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangueapp/bloc/BTCubit/bt_cubit.dart';
import 'package:mangueapp/resources/widgets/option_widget.dart';

class BluetoothIdle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BtCubit cubit = BlocProvider.of<BtCubit>(context);
    return Column(
      children: [
        const Text("Conectado"),
        InkWell(
            onTap: () {
              cubit.disconnectBt();
            },
            child: const ThemeContainer(text: "Desconectar")),
      ],
    );
  }
}
