import 'package:flutter/material.dart';
import 'package:marketplace/auth/login.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 255, 248, 240),
        child: Stack(
          children: [
            // Gambar latar belakang
            Positioned.fill(
              child: Image.asset(
                "assets/images/welcome_screen.png",
                fit: BoxFit.cover,
              ),
            ),
            // Gambar Clothify di bagian atas
            Positioned(
              top: 10, // Jarak dari bagian atas
              left: 0,
              right: 0,
              child: Center(
                child: Image.asset(
                  "assets/images/clothify_white_no_back.png",
                  width: 300,
                ),
              ),
            ),
            // Tombol di atas gambar, berada di bagian bawah
            Positioned(
              bottom: 100,
              left: 0,
              right: 0,
              child: Center(
                child: SizedBox(
                  width: 200,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 146, 20, 12), //
                    ),
                    child: const Text(
                      "Get Started",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 248, 240),
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
