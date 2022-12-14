import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangueapp/resources/widgets/navigation_bar.dart';
import '../../bloc/AppModeCubit/app_mode_cubit.dart';
import '../../resources/widgets/option_widget.dart';

class ConfigScreen extends StatelessWidget {
  const ConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const MainNavigationBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "Settings",
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 30),
                ),
              ),
              ListView(
                shrinkWrap: true,
                children: [
                  // InkWell(
                  //     onTap: () {
                  //       Navigator.of(context).pushNamed(themeRoute);
                  //     },
                  //     child: const ThemeContainer(text: "Themes")),
                  // InkWell(
                  //     onTap: () {
                  //       Navigator.of(context).pushNamed(themeRoute);
                  //     },
                  //     child: const ThemeContainer(text: "DevMode")),
                  BlocBuilder<AppModeCubit, AppModeState>(
                    builder: (context, state) {
                      if (state is AppModeAsync) {
                        return InkWell(
                            onTap: () {
                              BlocProvider.of<AppModeCubit>(context)
                                  .changeMode(context);
                            },
                            child: const ThemeContainer(text: "Sync"));
                      } else {
                        return InkWell(
                            onTap: () {
                              BlocProvider.of<AppModeCubit>(context)
                                  .changeMode(context);
                            },
                            child: const ThemeContainer(text: "Async"));
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
