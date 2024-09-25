import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketplace/e_wallet_screen.dart';
import 'cart_empty_screen.dart';
import 'payment_screen.dart';
import 'cart_screen.dart';
import 'checkout_screen.dart';

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
      theme: ThemeData(textTheme: GoogleFonts.urbanistTextTheme()),
      home: const CheckoutScreen(),
    );
  }
}
