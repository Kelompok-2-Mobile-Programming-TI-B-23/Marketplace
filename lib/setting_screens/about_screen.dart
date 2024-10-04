import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 248, 240),
      appBar: AppBar(
        title: Text(
          'About Us',
          style: GoogleFonts.urbanist(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 248, 240),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: const Text(
          'Clothify adalah aplikasi marketplace yang bertujuan untuk menghubungkan penjual dan pembeli produk fashion di seluruh Indonesia. Kami percaya bahwa semua orang berhak memiliki akses ke produk fashion berkualitas dengan harga yang terjangkau. Dengan menggunakan Clothify, pengguna dapat menemukan berbagai pakaian, aksesoris, dan produk fashion dari berbagai penjual di seluruh Indonesia.\n\nKami berkomitmen untuk menyediakan platform yang aman, mudah digunakan, dan mendukung transaksi yang transparan. Clothify didirikan pada tahun 2024 dengan misi untuk merevolusi cara orang membeli dan menjual pakaian secara online. Kami terus berinovasi untuk memberikan pengalaman belanja terbaik bagi semua pengguna kami.',
          style: TextStyle(
            fontSize: 16,
            height: 1.5,
          ),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
