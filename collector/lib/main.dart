import 'package:collector/components/Colorpallet.dart';
import 'package:collector/navbar/NavigationBar.dart';
import 'package:collector/navbar/app_navigation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
              color: ColorPalette.Jungle_Green,
              iconTheme: IconThemeData(color: Colors.white)),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedIconTheme:
                  IconThemeData(color: ColorPalette.appBar_color),
              unselectedIconTheme:
                  IconThemeData(color: ColorPalette.Jungle_Green))),
      debugShowCheckedModeBanner: false,
      routerConfig: AppNavigation.router,
    );
  }
}
