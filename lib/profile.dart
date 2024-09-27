import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketplace/editprofile.dart';
import 'package:marketplace/login.dart';
import 'package:marketplace/settings.dart';
import 'package:marketplace/purchase_history_screen.dart';

// commit profile
class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 248, 240),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 248,
            240), //Warna background buat clothify pake ini semua (krem)
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Profile', // Judul yang ada di tengah AppBar
          style: GoogleFonts.urbanist(
            textStyle: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(
                    255, 146, 20, 12)), // Warna default clothify (merah)
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(255, 255, 248, 240),
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16),
              CircleAvatar(
                radius: 50,
                backgroundColor: const Color.fromARGB(255, 146, 20, 12),
                child: Icon(
                  CupertinoIcons.person,
                  color: Colors.white,
                  size: 50,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'User',
                style: GoogleFonts.urbanist(
                  textStyle: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                '+62 123 4567 890',
                style: GoogleFonts.urbanist(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'example@gmail.com',
                style: GoogleFonts.urbanist(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Divider(), // Garis horizontal
              ListTile(
                title: Text(
                  'Edit Profile',
                  style: GoogleFonts.urbanist(),
                ),
                trailing: Icon(CupertinoIcons.pencil, color: Colors.black),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => editprofile()));
                },
              ),
              Divider(),
              ListTile(
                title: Text(
                  'Change Password',
                  style: GoogleFonts.urbanist(),
                ),
                trailing: Icon(CupertinoIcons.lock, color: Colors.black),
                onTap: () {},
              ),
              Divider(),
              ListTile(
                title: Text(
                  'E-Wallet',
                  style: GoogleFonts.urbanist(),
                ),
                trailing: Icon(CupertinoIcons.creditcard, color: Colors.black),
                onTap: () {},
              ),
              Divider(),
              ListTile(
                title: Text(
                  'Purchase History',
                  style: GoogleFonts.urbanist(),
                ),
                trailing: Icon(CupertinoIcons.clock, color: Colors.black),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PurchaseHistoryScreen()),
                  );
                },
              ),
              Divider(),
              ListTile(
                title: Text(
                  'Settings',
                  style: GoogleFonts.urbanist(),
                ),
                trailing: Icon(CupertinoIcons.settings, color: Colors.black),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Settings()));
                },
              ),
              Divider(),
              ListTile(
                title: Text(
                  'Log Out',
                  style: GoogleFonts.urbanist(
                    textStyle: const TextStyle(
                      color: Color.fromARGB(255, 146, 20, 12),
                    ),
                  ),
                ),
                trailing: Icon(CupertinoIcons.square_arrow_right,
                    color: const Color.fromARGB(255, 146, 20, 12)),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
