import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangueapp/bloc/BTCubit/bt_cubit.dart';
import 'package:mangueapp/resources/widgets/option_widget.dart';

class BluetoothList extends StatelessWidget {
  const BluetoothList({super.key});

  @override
  Widget build(BuildContext context) {
    BtCubit btcubit = BlocProvider.of<BtCubit>(context);
    if (btcubit.getDevices().isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Nothing Found"),
          Padding(
            padding: const EdgeInsets.all(20 ),
            child: GestureDetector(
              onTap: () {
                btcubit.lookForDevices();
              },
              child: const BLuetoothContainer(text: "Try again"),
            ),
          ),
        ],
      );
    } else {
      return ListView.separated(
        padding: const EdgeInsets.all(8.0),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              btcubit.connectToDevice(btcubit.getDevices()[index]!);
            },
            child: BLuetoothContainer(
              text: btcubit.getDevices()[index]!.toString(),
            ),
          );
        },
        itemCount: 5, //btcubit.getDevices().length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      );
    }
  }
}
