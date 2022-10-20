import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangueapp/bloc/MQttConCubit/mqtt_con_cubit.dart';
import 'package:mangueapp/resources/widgets/navigation_bar.dart';
import 'package:mangueapp/resources/widgets/option_widget.dart';

class MqttPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MqttConCubit connectionCubit = BlocProvider.of<MqttConCubit>(context);
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const MainNavigationBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
                onTap: () {
                  connectionCubit.connect();
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: BLuetoothContainer(text: "Connect"),
                )),
            InkWell(
                onTap: () {
                  connectionCubit.publish();
                },
                child: const BLuetoothContainer(text: "Send Flag")),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: BlocBuilder<MqttConCubit, MqttConState>(
                builder: (context, state) {
                  if (state is MqttConnected) {
                    return const BLuetoothContainer(text: "Conectado");
                  } else if (state is MqttConnecting) {
                    return const CircularProgressIndicator();
                  } else {
                    return const BLuetoothContainer(
                      text: "Disconectado",
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
