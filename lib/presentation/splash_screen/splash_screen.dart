import 'package:flutter/material.dart';
import 'package:mangueapp/config/routes/routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushNamed(bluetoothRoute);
    });
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/Icons/Header/caxanga.png",
              width: 300,
              height: 300,
            ),
            const Text(
              "Bem vindo!",
              style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
