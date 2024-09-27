import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 248, 240), // Warna Krem
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 248, 240), // Warna krem
        elevation: 0, // No shadow
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back,
              color: Colors.black), // ikon panah ke kiri
          onPressed: () {
            Navigator.pop(context); // Go back to Profile screen
          },
        ),
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: GoogleFonts.urbanist(
            textStyle: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black, // Warna hitam
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Stack biar icon pensil bisa nempel ke avatar
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

              // Nama
              buildLabelText('Full Name'),
              buildTextField(''),

              const SizedBox(height: 16),

              // Username
              buildLabelText('Username'),
              buildTextField(''),

              const SizedBox(height: 16),

              // Address
              buildLabelText('Address'),
              buildTextField(''),

              const SizedBox(height: 16),

              // Phone Number
              buildLabelText('Phone Number'),
              buildTextField(''),

              const SizedBox(height: 32),

              // Button save
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Return to the Profile screen
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  backgroundColor:
                      const Color.fromARGB(255, 146, 20, 12), // Warna merah
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Save Changes',
                  style: GoogleFonts.urbanist(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
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

  // Widget buat label text
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

  // Widget buat text field
  Widget buildTextField(String hintText) {
    return TextFormField(
      initialValue: hintText,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
