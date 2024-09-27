import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketplace/profile.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 248, 240),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 248, 240),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Colors.black),
          onPressed: () {
            Navigator.pop(
              context,
              MaterialPageRoute(builder: (context) => Profile()),
            );
          },
        ),
        centerTitle: true,
        title: Text(
          'Settings',
          style: GoogleFonts.urbanist(
            textStyle: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(255, 255, 248, 240),
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              ListTile(
                leading: const Icon(Icons.language, color: Colors.black),
                title: Text(
                  'Language',
                  style: GoogleFonts.urbanist(),
                ),
                trailing: const Icon(CupertinoIcons.right_chevron,
                    color: Colors.black),
                onTap: () {
                  _showLanguageDialog(context);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.dark_mode, color: Colors.black),
                title: Text(
                  'Display',
                  style: GoogleFonts.urbanist(),
                ),
                trailing: const Icon(CupertinoIcons.right_chevron,
                    color: Colors.black),
                onTap: () {
                  _showThemeDialog(context);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.help_outline, color: Colors.black),
                title: Text(
                  'FAQ',
                  style: GoogleFonts.urbanist(),
                ),
                trailing: const Icon(CupertinoIcons.right_chevron,
                    color: Colors.black),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.description, color: Colors.black),
                title: Text(
                  'Terms & Conditions',
                  style: GoogleFonts.urbanist(),
                ),
                trailing: const Icon(CupertinoIcons.right_chevron,
                    color: Colors.black),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.lock_outline, color: Colors.black),
                title: Text(
                  'Privacy Policy',
                  style: GoogleFonts.urbanist(),
                ),
                trailing: const Icon(CupertinoIcons.right_chevron,
                    color: Colors.black),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.info_outline, color: Colors.black),
                title: Text(
                  'About Us',
                  style: GoogleFonts.urbanist(
                    textStyle: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                trailing: const Icon(CupertinoIcons.right_chevron,
                    color: Colors.black),
                onTap: () {},
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi menampilkan pop up dialog jika 'Language di klik'
  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Language"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text("English (Default)"),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              const Divider(),
              ListTile(
                title: const Text("Indonesia"),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Fungsi menampilkan pop up dialog jika 'Display di klik'
  void _showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Theme"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text("Light Mode (Default)"),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              const Divider(),
              ListTile(
                title: const Text("Dark Mode"),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
