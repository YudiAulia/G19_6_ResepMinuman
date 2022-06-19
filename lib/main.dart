import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projek_pemob/Screens/HomePage.dart';
import 'package:projek_pemob/screens/input.dart';
import 'package:projek_pemob/screens/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widgets/NewRecipe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;

  runApp(MyApp(showHome: showHome));
}

class MyApp extends StatelessWidget {
  final bool showHome;

  MyApp({Key? key, required this.showHome}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Resep Minuman',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Anton',
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(showHome: showHome),
    );
  }
}
