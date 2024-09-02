import 'package:app/screens/auth.dart';
import 'package:app/screens/home.dart';
import 'package:app/screens/new_arrival.dart';
import 'package:app/screens/notifications.dart';
import 'package:app/screens/verification.dart';
import 'package:flutter/material.dart';
import 'package:app/screens/forget_password.dart';
import 'package:app/screens/sign_in.dart';
import 'package:app/screens/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: NotificationScreen());
  }
}
