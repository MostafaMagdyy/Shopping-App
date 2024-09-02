import 'package:flutter/material.dart';
import 'dart:async';
import 'package:app/screens/home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF171717), 
      body: Stack(
        children: [
          Positioned(
            top: 55,
            left: -10,
            child: Image.asset(
              'assets/Ellipse_Splash.png',
            ),
          ),
          Positioned(
            top: 140,
            left: 230,
            child: Image.asset(
              'assets/Ellipse_Splash2.png',
            ),
          ),
          // Place the main image on top
          Center(
            child: Image.asset(
              'assets/Mool_Splash.png',
              width: 302.82,
              height: 150,
            ),
          ),
        ],
      ),
    );
  }
}
