import 'dart:async';
import 'package:flutter/material.dart';
import 'package:projek_pemob/main.dart';
import 'package:projek_pemob/screens/HomePage.dart';
import 'package:projek_pemob/screens/LandingPage.dart';

class SplashScreen extends StatefulWidget {
  final bool showHome;
  const SplashScreen({Key? key, required this.showHome}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState(showHome);
}

class _SplashScreenState extends State<SplashScreen> {
  bool _showHome;

  _SplashScreenState(this._showHome);

  @override
  void initState() {
    super.initState();
    splashScreenStart();
  }

  splashScreenStart() {
    var duration = const Duration(seconds: 5);
    return Timer(duration, () {
      _showHome ?
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyHomePage()))
      : Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => landingPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue,
              Color.fromARGB(255, 144, 132, 253),
            ],
          ),
        ),
        child: Center(
          child: Image.asset("assets/logo1.png"),
        ),
      ),
    );
  }
}
