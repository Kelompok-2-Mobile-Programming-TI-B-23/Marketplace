import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketplace/editprofile.dart';
import 'package:marketplace/profile.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(
            255, 255, 248, 240), // Warna background buat clothify (krem)
        elevation: 0,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back,
              color: Colors.black), // Ikon panah ke kiri
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Profile()), // Sementara route ke Profile
            );
          },
        ),
        centerTitle: true,
        title: Text(
          'Clothify', // Judul di AppBar
          style: GoogleFonts.urbanist(
            textStyle: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(
                  255, 146, 20, 12), // Warna merah clothify
            ),
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
              Text(
                'Settings',
                style: GoogleFonts.urbanist(
                  textStyle: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 30),
              ListTile(
                leading:
                    Icon(Icons.language, color: Colors.black), // Ikon di kiri
                title: Text(
                  'Language',
                  style: GoogleFonts.urbanist(),
                ),
                trailing: Icon(CupertinoIcons.right_chevron,
                    color: Colors.black), // Panah di kanan
                onTap: () {},
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.dark_mode, color: Colors.black),
                title: Text(
                  'Display',
                  style: GoogleFonts.urbanist(),
                ),
                trailing:
                    Icon(CupertinoIcons.right_chevron, color: Colors.black),
                onTap: () {},
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.help_outline, color: Colors.black),
                title: Text(
                  'FAQ',
                  style: GoogleFonts.urbanist(),
                ),
                trailing:
                    Icon(CupertinoIcons.right_chevron, color: Colors.black),
                onTap: () {},
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.description, color: Colors.black),
                title: Text(
                  'Terms & Conditions',
                  style: GoogleFonts.urbanist(),
                ),
                trailing:
                    Icon(CupertinoIcons.right_chevron, color: Colors.black),
                onTap: () {},
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.lock_outline, color: Colors.black),
                title: Text(
                  'Privacy Policy',
                  style: GoogleFonts.urbanist(),
                ),
                trailing:
                    Icon(CupertinoIcons.right_chevron, color: Colors.black),
                onTap: () {},
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.info_outline, color: Colors.black),
                title: Text(
                  'About Us',
                  style: GoogleFonts.urbanist(
                    textStyle: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                trailing:
                    Icon(CupertinoIcons.right_chevron, color: Colors.black),
                onTap: () {},
              ),
              Divider(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey, width: 0.4), // Garis border
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: 3, // Dummy index yang sedang aktif
          selectedItemColor: const Color.fromARGB(255, 146, 20, 12),
          unselectedItemColor: const Color.fromARGB(255, 95, 80, 80),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.storefront_outlined),
              label: 'Store',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: 'Profile',
            ),
          ],
          selectedLabelStyle: GoogleFonts.urbanist(),
          unselectedLabelStyle: GoogleFonts.urbanist(),
          showUnselectedLabels: true,
        ),
      ),
    );
  }
}
