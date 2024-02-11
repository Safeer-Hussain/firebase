import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../pages/home_page.dart';
import '../pages/login_page.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      final FirebaseAuth auth = FirebaseAuth.instance;
      if (auth.currentUser != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const MyHomePage()));
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
      }
    });
  }
}
