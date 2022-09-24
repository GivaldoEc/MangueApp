import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangueapp/bloc/BTCubit/bt_cubit.dart';

class BLuetoothContainer extends StatelessWidget {
  const BLuetoothContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    BtCubit btcubit = BlocProvider.of<BtCubit>(context);

    return Container(
      width: 380,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: const BorderRadius.all(Radius.circular(40))),
      child: const Text("RAM"),
    );
  }
}
