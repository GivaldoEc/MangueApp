import 'package:flutter/material.dart';
import 'package:mangueapp/resources/widgets/navigation_bar.dart';

import '../../config/routes/routes.dart';
import '../../resources/widgets/option_widget.dart';

class ConfigScreen extends StatelessWidget {
  const ConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MainNavigationBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
        child: ListView(
          children: [
            InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(themeRoute);
                },
                child: const ThemeContainer(text: "Themes")),
          ],
        ),
      ),
    );
  }
}
