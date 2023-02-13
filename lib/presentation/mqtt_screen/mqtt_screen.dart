import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangueapp/bloc/MQttConCubit/mqtt_con_cubit.dart';
import 'package:mangueapp/resources/widgets/navigation_bar.dart';
import 'package:mangueapp/resources/widgets/option_widget.dart';
import 'package:mangueapp/resources/widgets/progress_indicator.dart';

class MqttPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MqttConCubit connectionCubit = BlocProvider.of<MqttConCubit>(context);
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const MainNavigationBar(),
        body: Center(
          child: BlocBuilder<MqttConCubit, MqttConState>(
            builder: (context, state) {
              if (state is MqttDisconnected || state is MqttConInitial) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/Icons/Header/caxanga.png",
                      width: 200,
                      height: 200,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(14.0),
                      child: Text(
                        "Disconected!",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 40,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        connectionCubit.connect();
                      },
                      child: const MqttContainer(text: "Connect"),
                    )
                  ],
                );
              } else if (state is MqttConnecting) {
                return SizedBox(
                  height: 200,
                  width: 200,
                  child: AppProgressIndicator(),
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/Icons/Header/caxanga.png",
                      width: 200,
                      height: 200,
                    ),
                    const Text(
                      "Connected",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 40,
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          connectionCubit.disconnect();
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: MqttContainer(text: "Disconnect"),
                        )),
                    InkWell(
                        onTap: () {
                          //connectionCubit.publish(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: MqttContainer(text: "Test Packet"),
                        )),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
