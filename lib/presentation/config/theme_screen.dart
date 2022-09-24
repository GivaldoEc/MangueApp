import 'package:flutter/material.dart';
import 'package:mangueapp/config/routes/routes.dart';
import 'package:mangueapp/resources/widgets/option_widget.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.bluetooth),
        onPressed: () => Navigator.pushNamed(context, init),),
      body: Center(
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
    );
  }
}
