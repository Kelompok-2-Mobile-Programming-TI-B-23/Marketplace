import 'package:flutter/material.dart';
import 'cart_empty_screen.dart';
import 'payment_screen.dart';
import 'cart_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Urbanist'),
      home: const CartScreen(),
    );
  }
}
