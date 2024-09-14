import 'package:flutter/material.dart';
import 'package:marketplace/homepage.dart';
import 'package:marketplace/welcome_screen.dart';
import 'package:marketplace/login.dart';
import 'bottomNavigator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.black, // Warna kursor
          selectionHandleColor: Color.fromARGB(255, 146, 20, 12),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: SafeArea(child: HomepageScreen()),
    );
  }
}
