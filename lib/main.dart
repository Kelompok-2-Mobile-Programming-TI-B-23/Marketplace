import 'package:flutter/material.dart';
import 'package:marketplace/e_wallet_screen.dart';
import 'filter_sort_screen.dart';
import 'search_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketplace/e_wallet_screen.dart';
import 'cart_empty_screen.dart';
import 'payment_screen.dart';
import 'cart_screen.dart';
import 'checkout_screen.dart';
import 'package:marketplace/homepage.dart';
import 'package:marketplace/welcome_screen.dart';
import 'package:marketplace/login.dart';
import 'widgets/bottomNavigator.dart';
import 'package:marketplace/purchase_history_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // Font Urbanist ke seluruh app
        textTheme: GoogleFonts.urbanistTextTheme(
          Theme.of(context).textTheme,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.black, // Warna kursor
          selectionHandleColor: Color(0xFF92104C),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const SafeArea(child: LoginScreen()),
    );
  }
}
