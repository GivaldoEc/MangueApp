import 'package:flutter/material.dart';
import 'package:mangueapp/resources/widgets/option_widget.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    // TODO: implement theme cubit list here
                  },
                  child: const ThemeContainer(
                    text: "randomtheme",
                  ),
                );
              },
              itemCount: 5, // TODO: implement bloc solution
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
          ),
        ),
      ),
    );
  }
}
