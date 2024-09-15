import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketplace/register.dart';
import 'package:icons_plus/icons_plus.dart'; // Library untuk ikon media sosial

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
          0xFFFDF0E6), // Warna latar belakang yang sesuai dengan desain
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              // Logo Clothify
              Center(
                child: Image.asset(
                  'assets/images/clothify_red_no_back.png', // Pastikan path ini benar
                  width: 200,
                ),
              ),
              const SizedBox(height: 20),
              // Teks "Login"
              Text(
                "Login",
                style: GoogleFonts.urbanist(
                  textStyle: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Input Email
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: GoogleFonts.urbanist(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Input Password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: GoogleFonts.urbanist(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Tombol Login
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Aksi login
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 146, 20, 12),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Login",
                      style: GoogleFonts.urbanist(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Teks "OR Continue with"
              Text(
                "- OR Continue with -",
                style: GoogleFonts.urbanist(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              // Ikon Google, Apple, Facebook
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Tombol Google
                    IconButton(
                      onPressed: () {
                        // Aksi login dengan Google
                      },
                      // icon: Icon(
                      //   Icons.apple_outlined,
                      //   color: Colors.red,
                      //   size: 30,
                      // ),
                      icon: Brand(Brands.google),
                    ),
                    // Tombol Apple
                    IconButton(
                      onPressed: () {
                        // Aksi login dengan Apple
                      },
                      // icon: Icon(
                      //   Icons.apple_outlined,
                      //   color: Colors.black,
                      //   size: 30,
                      // ),
                      icon: Brand(Brands.instagram),
                    ),
                    // Tombol Facebook
                    IconButton(
                        onPressed: () {
                          // Aksi login dengan Facebook
                        },
                        // icon: Icon(
                        //   Icons.facebook_outlined,
                        //   color: Colors.blue,
                        //   size: 30,
                        // ),
                        icon: Brand(Brands.facebook)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Teks "Create An Account" dan "Sign Up"
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Create An Account",
                    style: GoogleFonts.urbanist(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      // Aksi untuk pindah ke halaman signup
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterScreen()),
                      );
                    },
                    child: Text(
                      "Sign Up",
                      style: GoogleFonts.urbanist(
                        fontSize: 14,
                        color: Color.fromARGB(255, 146, 20, 12),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
