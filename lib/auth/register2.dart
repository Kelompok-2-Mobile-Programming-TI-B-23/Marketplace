import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketplace/auth/register3.dart';
import 'package:marketplace/widgets/clothify_logo.dart';
import 'package:marketplace/model/user_model.dart';
import 'package:marketplace/auth/authentication.dart';
import 'package:marketplace/widgets/snackbar.dart';

class RegisterScreen2 extends StatelessWidget {
  final UserModel user; // Accept UserModel as a parameter
  const RegisterScreen2({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController addressController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFFFDF0E6),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),
                  const ClothifyLogo(width: 300),
                  const SizedBox(height: 80),
                  Text(
                    "Complete Profile",
                    style: GoogleFonts.urbanist(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Form(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: usernameController,
                          decoration: InputDecoration(
                            labelText: "Username",
                            labelStyle:
                                GoogleFonts.urbanist(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 146, 20, 12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: phoneController,
                          decoration: InputDecoration(
                            labelText: "Phone Number",
                            labelStyle:
                                GoogleFonts.urbanist(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 146, 20, 12),
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: addressController,
                          decoration: InputDecoration(
                            labelText: "Address",
                            labelStyle:
                                GoogleFonts.urbanist(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 146, 20, 12),
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () async {
                        // Update user data before moving to the next screen
                        user.username = usernameController.text;
                        user.phoneNumber = phoneController.text;
                        user.address = addressController.text;
                        String res = await Authentication().signupUser(
                          email: user.email,
                          password: user.password,
                          username: user.username,
                          phoneNumber: user.phoneNumber,
                          address: user.address,
                        );
                        if (res == "success") {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen3(),
                            ),
                          );
                        } else {
                          // Handle error
                          showSnackBar(context, res);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 146, 20, 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: Text(
                        "Create Account",
                        style: GoogleFonts.urbanist(
                            fontSize: 20, color: Colors.white),
                      ),
                    ),
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
