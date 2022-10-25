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
            padding: const EdgeInsets.all(20),
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
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.separated(
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
              itemCount: btcubit.getDevices().length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
          ),
          GestureDetector(
            child: const BLuetoothContainer(text: "Look Again"),
            onTap: () {
              btcubit.lookForDevices();
            },
          ),
        ],
      );
    }
  }
}

class CharacteristicList extends StatelessWidget {
  const CharacteristicList({super.key});

  @override
  Widget build(BuildContext context) {
    BtCubit btCubit = BlocProvider.of<BtCubit>(context);
    if (btCubit.getCharacteristics().isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const BLuetoothContainer(text: "Conectado!"),
          GestureDetector(
            onTap: () {
              btCubit.scanCharacteristics();
            },
            child: const BLuetoothContainer(text: "Listar Caracteristicas"),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    if (btCubit.asyncMode == true) {
                      btCubit.sendOpenRequisition(
                        btCubit.getCharacteristics()[index],
                      );
                    } else {
                      btCubit.synchronize();
                    }
                  },
                  child: BLuetoothContainer(
                      text: btCubit.getCharacteristics()[index].toString()),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemCount: btCubit.getCharacteristics().length,
            ),
          ),
          GestureDetector(
            onTap: () {
              btCubit.scanCharacteristics();
            },
            child: const BLuetoothContainer(text: "Buscar novamente"),
          ),
          GestureDetector(
            onTap: () {
              btCubit.disconnectBt();
            },
            child: const BLuetoothContainer(text: "Desconectar"),
          ),
        ],
      );
    }
  }
}
