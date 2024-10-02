import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
  }

  Future<void> _fetchUserData() async {
    if (_user != null) {
      DocumentSnapshot userData =
          await _firestore.collection('users').doc(_user!.uid).get();

      // Set initial values for text fields
      _emailController.text = userData['email'] ?? 'Email';
      _usernameController.text = userData['username'] ?? 'Username';
      _addressController.text = userData['address'] ?? 'Address';
      _phoneNumberController.text = userData['phoneNumber'] ?? '+ 0812345678';
    }
  }

  Future<void> _saveChanges() async {
    if (_user != null) {
      // Update user data in Firestore
      await _firestore.collection('users').doc(_user!.uid).update({
        'address': _addressController.text,
        'phoneNumber': _phoneNumberController.text,
      });
      // Show success message
      _showDialog('Profile updated successfully!');
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
      backgroundColor: const Color.fromARGB(255, 255, 248, 240), // Cream color
      appBar: AppBar(
        backgroundColor:
            const Color.fromARGB(255, 255, 248, 240), // Cream color
        elevation: 0, // No shadow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded,
              color: Colors.black), // Back arrow
          onPressed: () {
            Navigator.pop(context); // Go back to Profile screen
          },
        ),
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: GoogleFonts.urbanist(
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: _fetchUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 146, 20, 12),
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error fetching user data.'));
          }

          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Stack for avatar and edit icon
                  const Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Color.fromARGB(255, 146, 20, 12),
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 16,
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Username
                  buildLabelText('Username'),
                  lockedTextField(_usernameController, 'Username'),

                  const SizedBox(height: 16),

                  // Email
                  buildLabelText('Email'),
                  lockedTextField(_emailController, 'Email'),

                  const SizedBox(height: 16),

                  // Phone Number
                  buildLabelText('Phone Number'),
                  buildTextField(_phoneNumberController, 'Phone Number'),

                  const SizedBox(height: 16),

                  // Address
                  buildLabelText('Address'),
                  buildTextField(_addressController, 'Address'),

                  const SizedBox(height: 40),

                  // Save Changes button
                  ElevatedButton(
                    onPressed: () {
                      _saveChanges(); // Save user changes
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 32),
                      backgroundColor:
                          const Color.fromARGB(255, 146, 20, 12), // Red color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: Text(
                      'Save Changes',
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
          );
        },
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
  Widget buildTextField(TextEditingController controller, String hintText) {
    return TextFormField(
      controller: controller,
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

  // Widget for Locked text field
  Widget lockedTextField(TextEditingController controller, String hintText) {
    return TextFormField(
      controller: controller,
      enabled: false,
      style: const TextStyle(color: Colors.grey),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black),
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.black),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _addressController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }
}
