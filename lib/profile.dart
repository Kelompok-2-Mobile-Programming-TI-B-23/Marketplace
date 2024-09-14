import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketplace/login.dart';

// commit profile
class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 248,
            240), //Warna background buat clothify pake ini semua (krem)
        elevation: 0,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back,
              color: Colors.black), // ikon panah ke kiri
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const LoginScreen()), // Sementara route ngasal dulu (harusnya home nanti)
            );
          },
        ),
        centerTitle: true,
        title: Text(
          'Clothify', // Judul yang ada di tengah AppBar
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
              Text(
                'Profile',
                style: GoogleFonts.urbanist(
                  textStyle: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
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
                onTap: () {},
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
                onTap: () {},
              ),
              Divider(),
              ListTile(
                title: Text(
                  'Settings',
                  style: GoogleFonts.urbanist(),
                ),
                trailing: Icon(CupertinoIcons.settings, color: Colors.black),
                onTap: () {},
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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey, width: 0.4), // Garis border
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: 2, // dummy index mana yg lg d klik
          selectedItemColor: const Color.fromARGB(255, 146, 20, 12),
          unselectedItemColor: const Color.fromARGB(255, 95, 80, 80),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.store),
              label: 'Store',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_crop_circle_fill),
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
