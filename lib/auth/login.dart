import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketplace/auth/register.dart';
import 'package:icons_plus/icons_plus.dart'; // Library untuk ikon media sosial
import 'package:marketplace/auth/resetpassword.dart';
import 'package:marketplace/widgets/clothify_logo.dart';
import 'package:marketplace/homepage.dart';
import 'package:marketplace/auth/authentication.dart';
import 'package:marketplace/widgets/snackbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

// email and passowrd auth part
  void loginUser() async {
    setState(() {
      isLoading = true;
    });
    // signup user using our Authentication
    String res = await Authentication().loginUser(
        email: emailController.text, password: passwordController.text);

    if (res == "success") {
      setState(() {
        isLoading = false;
      });
      //navigate to the home screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomepageScreen(),
        ),
      );
    } else {
      setState(() {
        isLoading = false;
      });
      // show error
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          true, // Untuk nyesuain ukuran layar saat keyboard muncul
      backgroundColor: const Color(0xFFFDF0E6),
      body: SafeArea(
        child: GestureDetector(
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
                  const SizedBox(height: 60),
                  const ClothifyLogo(
                    width: 300,
                  ),
                  const SizedBox(height: 80),
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
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: GoogleFonts.urbanist(
                            color: Colors.grey, fontSize: 16),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
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
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: GoogleFonts.urbanist(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
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
                    // how to make my text on the right
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ResetPassword()),
                        );
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Forgot Password",
                          style: GoogleFonts.urbanist(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  // Tombol Login
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          loginUser();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 146, 20, 12),
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
      ),
    );
  }
}
