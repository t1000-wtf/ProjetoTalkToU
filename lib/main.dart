import 'package:flutter/material.dart';
import 'package:talktou_app/src/screens/autismo_screen.dart';
import 'package:talktou_app/src/screens/login_screen.dart';
import 'package:talktou_app/src/screens/preference_screen.dart';
import 'package:talktou_app/src/screens/register_screen.dart';
import 'package:talktou_app/src/screens/soundsRelax_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UseDev',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),

      home: const LoginScreen(),
    );
  }
}
