import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newproject/consts/styles.dart';
import 'package:newproject/view/drawer_screen/details_screen.dart';
import 'package:newproject/view/drawer_screen/settings_screen.dart';
import 'package:newproject/view/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
        fontFamily: regular,
      ),
      routes: {
        DetailsScreen.routeName: (_) => const DetailsScreen(),
        SettingsScreen.routeName: (_) => const SettingsScreen(),
      },
      home: const SplashScreen(),
    );
  }
}
