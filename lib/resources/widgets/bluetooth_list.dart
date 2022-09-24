import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangueapp/bloc/BTCubit/bt_cubit.dart';
import 'package:mangueapp/resources/widgets/option_widget.dart';

class BluetoothList extends StatelessWidget {
  const BluetoothList({super.key});

  @override
  Widget build(BuildContext context) {
    BtCubit btcubit = BlocProvider.of<BtCubit>(context);
    if (false){//btcubit.getDevices().isEmpty){
    return const Text("Nothing Found");
  } else{
    return ListView.separated(
      padding: const EdgeInsets.all(8.0),
      itemBuilder: (BuildContext context, int index) {
        return const BLuetoothContainer();
      },
      itemCount: 5, //btcubit.getDevices().length,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );}
  }
}
