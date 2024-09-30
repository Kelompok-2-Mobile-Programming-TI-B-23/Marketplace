import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenTitle extends StatelessWidget {
  final String title;

  const ScreenTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        title,
        style: GoogleFonts.urbanist(
          textStyle: const TextStyle(
            fontSize: 30,
            color: Color.fromARGB(255, 146, 20, 12),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
