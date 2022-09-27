import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangueapp/bloc/BTCubit/bt_cubit.dart';
import 'package:mangueapp/config/routes/routes.dart';
import 'package:mangueapp/resources/widgets/bluetooth_list.dart';
import 'package:mangueapp/resources/widgets/option_widget.dart';

class BluetoothScreen extends StatelessWidget {
  final String appTitle = "Bluetooth App";

  const BluetoothScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, config);
        },
        child: const Icon(Icons.brush),
      ),
      appBar: AppBar(
        title: Text(appTitle),
      ),
      body: Center(
        child: BlocBuilder<BtCubit, BtState>(
          builder: (context, state) {
            if (state is BtInitial) {
              return const BLuetoothContainer(
                  text:
                      "Bem vindo! \nPressione o botão abaixo para buscar dispositivos!");
            } else if (state is BtOFF) {
              return const BLuetoothContainer(
                  text: "Para começar, ligue o bluetooth");
            } else if (state is BtDisconnected) {
              return const Center(child: BluetoothList());
            } else if (state is BtConnected){
              return Column(
                children: [
                  const BLuetoothContainer(text: "Conectado!"),
                  GestureDetector(onTap: () {
                    BlocProvider.of<BtCubit>(context).discoverServices(state.device);
                  }, child: const BLuetoothContainer(text: "Baixar"),)
                ],
              );
            } else if (state is BtSearching){
              return const CircularProgressIndicator();
            } else if (state is BtNothingFound){
              return const BLuetoothContainer(text: "Nothing found");
            } else {
              return const Text("Unknown Bloc State");
            }
          },
        ),
      ),
    );
  }
}
