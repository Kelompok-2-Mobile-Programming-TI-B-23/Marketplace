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
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.black, // Warna kursor
          selectionHandleColor: Color.fromARGB(255, 146, 20, 12),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: SafeArea(child: WelcomeScreen()),
    );
    return MaterialApp(
      title: 'Clothify',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFF8F0),
        ),
        useMaterial3: true,
      ),
      home: const PurchaseHistoryScreen(),
    );
  }
}
