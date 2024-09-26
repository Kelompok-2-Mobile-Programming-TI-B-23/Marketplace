import 'package:flutter/material.dart';
import 'filter_sort_screen.dart';
import 'search_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketplace/e_wallet_screen.dart';
import 'cart_empty_screen.dart';
import 'payment_screen.dart';
import 'cart_screen.dart';
import 'checkout_screen.dart';
import 'package:marketplace/homepage.dart';
import 'package:marketplace/welcome_screen.dart';
import 'package:marketplace/login.dart';
import 'bottomNavigator.dart';
import 'package:google_fonts/google_fonts.dart';

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
