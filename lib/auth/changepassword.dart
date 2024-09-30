import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _changePassword() async {
    String currentPassword = _currentPasswordController.text.trim();
    String newPassword = _newPasswordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    // Validasi Input
    if (currentPassword.isEmpty ||
        newPassword.isEmpty ||
        confirmPassword.isEmpty) {
      _showDialog('Please fill in all fields.');
      return;
    }

    if (newPassword != confirmPassword) {
      _showDialog('New password and confirmation do not match.');
      return;
    }

    User? user = _auth.currentUser;

    // Authentikasi Password User
    try {
      AuthCredential credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: currentPassword,
      );

      await user.reauthenticateWithCredential(credential);

      // Change the password
      await user.updatePassword(newPassword);

      _showDialog('Password changed successfully!');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        _showDialog('Current password is incorrect.');
      } else {
        _showDialog('Current password is incorrect.');
      }
    }
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 248, 240),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 248, 240),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Go back to Previous Screen
          },
        ),
        centerTitle: true,
        title: Text(
          'Change Password',
          style: GoogleFonts.urbanist(
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Stack(
                children: [
                  CircleAvatar(
                    radius: 100,
                    backgroundColor: Color.fromARGB(255, 146, 20, 12),
                    child: Icon(
                      Icons.shield_sharp,
                      color: Colors.white,
                      size: 150,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Text(
                'Create your new password',
                style: GoogleFonts.urbanist(
                  textStyle: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Current password
              buildLabelText('Current Password'),
              buildTextField(
                  _currentPasswordController, 'Current Password', true),

              const SizedBox(height: 16),

              // New password
              buildLabelText('New Password'),
              buildTextField(_newPasswordController, 'New Password', true),

              const SizedBox(height: 16),

              // Confirm password
              buildLabelText('Confirm Password'),
              buildTextField(
                  _confirmPasswordController, 'Confirm Password', true),

              const SizedBox(height: 40),

              // Change password button
              ElevatedButton(
                onPressed: () {
                  _changePassword();
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  backgroundColor: const Color.fromARGB(255, 146, 20, 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: Text(
                  'Change Password',
                  style: GoogleFonts.urbanist(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for label text
  Widget buildLabelText(String label) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: GoogleFonts.urbanist(
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }

  // Widget for text field
  Widget buildTextField(
      TextEditingController controller, String hintText, bool isObscure) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
      ),
    );
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
