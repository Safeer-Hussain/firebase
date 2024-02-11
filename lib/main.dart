import 'package:firebase/pages/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade900),
        // useMaterial3: true,
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
      ),
      home: const SplashPage(),
    );
  }
}
