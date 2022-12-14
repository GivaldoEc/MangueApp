import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangueapp/presentation/bluetooth/bluetooth_idle.dart';
import 'package:mangueapp/resources/widgets/navigation_bar.dart';
import 'package:mangueapp/resources/widgets/progress_indicator.dart';

import '../../bloc/BTCubit/bt_cubit.dart';
import '../../resources/widgets/bluetooth_list.dart';
import '../../resources/widgets/option_widget.dart';

class BluetoothWidget extends StatelessWidget {
  const BluetoothWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const MainNavigationBar(),
        body: Center(
          child: BlocBuilder<BtCubit, BtState>(
            builder: (context, state) {
              // bloc builder selection
              if (state is BtInitial) {
                return const BLuetoothContainer(
                    text:
                        "Bem vindo! \nPressione o botão abaixo para buscar dispositivos!");
              } else if (state is BtOFF) {
                return const BLuetoothContainer(
                    text: "Para começar, ligue o bluetooth");
              } else if (state is BtDisconnected) {
                return const BluetoothList();
              } 
              // else if (state is BtConnected) {
              //   return const CharacteristicList();
              // } 
              else if (state is BtSearching) {
                return AppProgressIndicator();
              } else if (state is BtDonwloading) {
                return SizedBox(
                  height: 100,
                  width: 100,
                  child: AppProgressIndicator(),
                );
              } else if (state is BtNothingFound) {
                return const BLuetoothContainer(text: "Nothing found");
              } else if (state is BtSync) {
                return BluetoothIdle();
              } else {
                return const Text("Unknown Bloc State");
              }
            },
          ),
        ),
      ),
    );
  }
}
