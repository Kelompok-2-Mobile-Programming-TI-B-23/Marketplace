import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketplace/profile.dart';

class Settings extends StatelessWidget {
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
            Navigator.pushReplacement(
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
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
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
              SizedBox(height: 30),
              ListTile(
                leading: Icon(Icons.language, color: Colors.black),
                title: Text(
                  'Language',
                  style: GoogleFonts.urbanist(),
                ),
                trailing:
                    Icon(CupertinoIcons.right_chevron, color: Colors.black),
                onTap: () {
                  _showLanguageDialog(context);
                },
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
                onTap: () {
                  _showThemeDialog(context);
                },
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
    );
  }

  // Fungsi menampilkan pop up dialog jika 'Language di klik'
  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Language"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text("English (Default)"),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              Divider(),
              ListTile(
                title: Text("Indonesia"),
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
          title: Text("Select Theme"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text("Light Mode (Default)"),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              Divider(),
              ListTile(
                title: Text("Dark Mode"),
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
