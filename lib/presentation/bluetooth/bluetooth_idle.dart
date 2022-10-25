import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangueapp/bloc/BTCubit/bt_cubit.dart';
import 'package:mangueapp/resources/widgets/option_widget.dart';

class BluetoothIdle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BtCubit cubit = BlocProvider.of<BtCubit>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/Icons/Header/caxanga.png",
          width: 200,
          height: 200,
        ),
        const Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(
            "Conectado!",
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 40,
            ),
          ),
        ),
        InkWell(
            onTap: () {
              cubit.disconnectBt();
            },
            child: const ThemeContainer(text: "Desconectar")),
      ],
    );
  }
}
