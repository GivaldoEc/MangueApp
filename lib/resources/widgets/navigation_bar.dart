import 'package:flutter/material.dart';

import '../../config/routes/routes.dart';

class MainNavigationBar extends StatelessWidget {
  const MainNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: IconTheme(
        data: const IconThemeData(color: Colors.black),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(bluetoothRoute);
                },
                icon: const Icon(Icons.bluetooth),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(graphRoute);
                },
                icon: const Icon(Icons.graphic_eq),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(mqttRoute);
                },
                icon: const Icon(Icons.wifi),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(configRoute);
                },
                icon: const Icon(Icons.settings),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
