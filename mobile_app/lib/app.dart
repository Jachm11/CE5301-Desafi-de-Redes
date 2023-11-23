import 'package:flutter/material.dart';
import 'package:mobile_app/screens/custom_getconf_screen.dart';
import 'package:mobile_app/screens/editconf_screen.dart';
import 'package:mobile_app/screens/fail_screen.dart';
import 'package:mobile_app/screens/getconf_screen.dart';
import 'package:mobile_app/screens/home_screen.dart';
import 'package:mobile_app/screens/ok_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (BuildContext context) => const HomeScreen(),
        FailScreen.routeName: (BuildContext context) => const FailScreen(),
        OkScreen.routeName: (BuildContext context) => const OkScreen(),
        GetconfScreen.routeName: (BuildContext context) =>
            const GetconfScreen(),
        EditconfScreen.routeName: (BuildContext context) =>
            const EditconfScreen(),
        CustomGetconfScreen.routeName: (BuildContext context) =>
            const CustomGetconfScreen(),
      },
    );
  }
}
