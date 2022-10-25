import 'package:flutter/material.dart';

class BLuetoothContainer extends StatelessWidget {
  final String text;

  const BLuetoothContainer({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: 380,
        decoration: BoxDecoration(
            border:
                Border.all(color: Colors.black), // TODO: Implement as textcolor
            borderRadius: const BorderRadius.all(Radius.circular(40))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(text),
        ),
      ),
    );
  }
}

class MqttContainer extends StatelessWidget {
  final String text;
  const MqttContainer({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ), // TODO: Implement as textcolor
          borderRadius: const BorderRadius.all(Radius.circular(40))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 25,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class ThemeContainer extends StatelessWidget {
  final String text;

  const ThemeContainer({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: 300,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
            ), // TODO: Implement as textcolor
            borderRadius: const BorderRadius.all(Radius.circular(40))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 25,
              color: Colors.black, // TODO: implement cubit
            ),
          ),
        ),
      ),
    );
  }
}
