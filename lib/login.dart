import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketplace/register.dart';
import 'package:icons_plus/icons_plus.dart'; // Library untuk ikon media sosial

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          true, // Untuk nyesuain ukuran layar saat keyboard muncul
      backgroundColor: const Color(0xFFFDF0E6),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context)
              .unfocus(); // Nutup keyboard saat area di luar TextField ditekan
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo Clothify
                const SizedBox(height: 50),
                Center(
                  child: Image.asset(
                    'assets/images/clothify_red_no_back.png',
                    width: 300,
                  ),
                ),
                const SizedBox(height: 30),
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
                const SizedBox(height: 20),
                // Input Email
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: GoogleFonts.urbanist(
                          color: Colors.grey, fontSize: 20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.grey, // Warna border saat tidak focus
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(
                              255, 146, 20, 12), // Warna border saat focus
                        ),
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
                        fontSize: 20,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.grey, // Warna border saat tidak focus
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(
                              255, 146, 20, 12), // Warna border saat focus
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 5),

                // Forgot Password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: GestureDetector(
                    onTap: () {
                      // Pindah ke halaman forgot password
                    },
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Forgot Password",
                        style: GoogleFonts.urbanist(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
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
                        backgroundColor: const Color.fromARGB(255, 146, 20, 12),
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: Text(
                        "Login",
                        style: GoogleFonts.urbanist(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                // Teks "OR Continue with"
                Text(
                  "- OR Continue with -",
                  style: GoogleFonts.urbanist(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 20),
                // Ikon Google, Instagram, Facebook
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Tombol Google
                      IconButton(
                        onPressed: () {},
                        icon: Brand(Brands.google),
                      ),
                      // Tombol Instagram
                      IconButton(
                        onPressed: () {},
                        icon: Brand(Brands.instagram),
                      ),
                      // Tombol Facebook
                      IconButton(
                          onPressed: () {}, icon: Brand(Brands.facebook)),
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
                        fontSize: 16,
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
                        "Sign Up Here",
                        style: GoogleFonts.urbanist(
                          fontSize: 16,
                          color: const Color.fromARGB(255, 146, 20, 12),
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
      ),
    );
  }
}
