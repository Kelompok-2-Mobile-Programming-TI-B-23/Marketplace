import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketplace/auth/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:marketplace/welcome_screen.dart';
import 'firebase_options.dart';
import 'package:marketplace/product_detail.dart';
import 'package:marketplace/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'online_shop/shop_main_screen.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure Flutter binding is initialized
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true);
  runApp(const MyApp());
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
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: const Color.fromARGB(
              255, 146, 20, 12), // Set the global loading indicator color
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const SafeArea(child: const WelcomeScreen()),
    );
  }
}
