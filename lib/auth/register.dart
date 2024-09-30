import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketplace/auth/login.dart';
import 'package:marketplace/auth/register2.dart';
import 'package:marketplace/widgets/clothify_logo.dart';
import 'package:marketplace/widgets/snackbar.dart';
import 'package:marketplace/auth/user_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signupUser() async {
    if (passwordController.text != passwordConfirmController.text) {
      showSnackBar(context, "Passwords do not match");
      return;
    }

    // set is loading to true.
    setState(() {
      isLoading = true;
    });

    // Create a UserModel instance
    UserModel user = UserModel(
      email: emailController.text,
      password: passwordController.text,
    );

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => RegisterScreen2(user: user),
      ),
    );
    // signup user using our authmethod
    // String res = await Authentication().signupUser(
    //   email: emailController.text,
    //   password: passwordController.text,
    // );
    // // if string return is success, user has been creaded and navigate to next screen other witse show error.
    // if (res == "success") {
    //   setState(() {
    //     isLoading = false;
    //   });
    //   //navigate to the next screen
    //   Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(
    //       builder: (context) => const LoginScreen(),
    //     ),
    //   );
    // } else {
    //   setState(() {
    //     isLoading = false;
    //   });
    //   // show error
    //   showSnackBar(context, res);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF0E6),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                const ClothifyLogo(width: 300),
                const SizedBox(height: 80),
                Text(
                  "Create Account",
                  style: GoogleFonts.urbanist(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Form(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailController,
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
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 146, 20, 12),
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: passwordController,
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
                          controller: passwordConfirmController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Password Confirm",
                            labelStyle: GoogleFonts.urbanist(
                              color: Colors.grey,
                            ),
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
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        signupUser();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 146, 20, 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: Text(
                        "Continue",
                        style: GoogleFonts.urbanist(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: GoogleFonts.urbanist(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      },
                      child: Text(
                        "Login",
                        style: GoogleFonts.urbanist(
                          color: const Color.fromARGB(255, 146, 20, 12),
                          fontSize: 16,
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
