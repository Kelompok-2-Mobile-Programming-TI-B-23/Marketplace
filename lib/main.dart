import 'package:flutter/material.dart';
import 'package:marketplace/welcome_screen.dart';
import 'package:marketplace/login.dart';
import 'package:marketplace/purchase_history_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.black, // Warna kursor
          selectionHandleColor: Color(0xFF92104C),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: SafeArea(child: PurchaseHistoryScreen()),
    );
  }
}
