import 'package:collector/components/Colorpallet.dart';
import 'package:collector/firebase_options.dart';
import 'package:collector/navbar/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true);

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
          elevatedButtonTheme: const ElevatedButtonThemeData(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(ColorPalette.Jungle_Green))),
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
