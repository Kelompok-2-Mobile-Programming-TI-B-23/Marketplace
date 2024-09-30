import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketplace/editprofile.dart';
import 'package:marketplace/auth/login.dart';
import 'package:marketplace/settings.dart';
import 'package:marketplace/purchase_history_screen.dart';
import 'package:marketplace/e_wallet_screen.dart';
import 'package:marketplace/purchase_history_screen.dart';
import 'package:marketplace/widgets/screen_title.dart';
import 'package:marketplace/auth/authentication.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 248, 240),
      // appBar: AppBar(
      //   backgroundColor: const Color.fromARGB(255, 255, 248, 240),
      //   elevation: 0,
      //   centerTitle: true,
      //   title: Text(
      //     'Profile',
      //     style: GoogleFonts.urbanist(
      //       textStyle: const TextStyle(
      //           fontSize: 24,
      //           fontWeight: FontWeight.bold,
      //           color: Color.fromARGB(255, 146, 20, 12)),
      //     ),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(255, 255, 248, 240),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              ScreenTitle(title: "Profile"),
              const SizedBox(height: 20),
              const CircleAvatar(
                radius: 50,
                backgroundColor: Color.fromARGB(255, 146, 20, 12),
                child: Icon(
                  CupertinoIcons.person,
                  color: Colors.white,
                  size: 50,
                ),
              ),
              const SizedBox(height: 16),
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
              const SizedBox(height: 8),
              Text(
                '+62 123 4567 890',
                style: GoogleFonts.urbanist(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'example@gmail.com',
                style: GoogleFonts.urbanist(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Divider(),
              ListTile(
                title: Text(
                  'Edit Profile',
                  style: GoogleFonts.urbanist(),
                ),
                trailing:
                    const Icon(CupertinoIcons.pencil, color: Colors.black),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditProfile()),
                  );
                },
              ),
              const Divider(),
              ListTile(
                title: Text(
                  'Change Password',
                  style: GoogleFonts.urbanist(),
                ),
                trailing: const Icon(CupertinoIcons.lock, color: Colors.black),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                title: Text(
                  'E-Wallet',
                  style: GoogleFonts.urbanist(),
                ),
                trailing:
                    const Icon(CupertinoIcons.creditcard, color: Colors.black),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EWalletScreen()),
                  );
                },
              ),
              const Divider(),
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
              const Divider(),
              ListTile(
                title: Text(
                  'Settings',
                  style: GoogleFonts.urbanist(),
                ),
                trailing:
                    const Icon(CupertinoIcons.settings, color: Colors.black),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Settings()),
                  );
                },
              ),
              const Divider(),
              ListTile(
                title: Text(
                  'Log Out',
                  style: GoogleFonts.urbanist(
                    textStyle: const TextStyle(
                      color: Color.fromARGB(255, 146, 20, 12),
                    ),
                  ),
                ),
                trailing: const Icon(CupertinoIcons.square_arrow_right,
                    color: Color.fromARGB(255, 146, 20, 12)),
                onTap: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.white,
                        title: Text(
                          "Konfirmasi Logout",
                          style: GoogleFonts.urbanist(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 28),
                          ),
                        ),
                        content: Text(
                          "Apakah Anda yakin ingin keluar?",
                          style: GoogleFonts.urbanist(
                            textStyle: const TextStyle(
                                color: Colors.black, fontSize: 16),
                          ),
                        ),
                        actions: [
                          TextButton(
                            child: Text(
                              "Tidak",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.urbanist(
                                textStyle: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text(
                              "Ya",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.urbanist(
                                textStyle: const TextStyle(
                                    color: Color.fromARGB(255, 146, 20, 12),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                            onPressed: () async {
                              await Authentication().signOut();
                              Navigator.of(context).pop();
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                                (route) => false,
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
