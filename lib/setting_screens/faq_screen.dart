import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 248, 240),
      appBar: AppBar(
        title: Text(
          'FAQ',
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
        child: ListView(
          children: [
            const Text(
              '1. Apa itu Clothify?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const Text(
                'Clothify adalah aplikasi marketplace yang memungkinkan pengguna untuk membeli dan menjual pakaian, aksesoris, serta produk fashion lainnya secara online. Kami menghubungkan pembeli dan penjual melalui platform yang aman dan mudah digunakan.',
                textAlign: TextAlign.justify),
            const Divider(),
            const Text(
              '2. Bagaimana cara mendaftar di Clothify?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const Text(
                'Anda dapat mendaftar dengan mengunduh aplikasi Clothify dari Play Store atau App Store. Setelah itu, pilih opsi "Daftar" dan isi informasi yang diperlukan, seperti alamat email, nomor telepon, dan kata sandi. Setelah verifikasi, Anda dapat langsung menggunakan aplikasi.',
                textAlign: TextAlign.justify),
            const Divider(),
            const Text(
              '3. Apakah Clothify gratis digunakan?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const Text(
                'Ya, Clothify dapat digunakan secara gratis oleh semua pengguna. Namun, biaya tambahan seperti biaya pengiriman dan pajak dapat berlaku untuk pembelian tertentu.',
                textAlign: TextAlign.justify),
            const Divider(),
            const Text(
              '4. Bagaimana cara menghubungi layanan pelanggan?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const Text(
                'Anda dapat menghubungi layanan pelanggan kami melalui fitur "Bantuan" di dalam aplikasi atau dengan mengirim email ke support@clothify.com. Kami siap membantu Anda setiap hari kerja.',
                textAlign: TextAlign.justify),
            const Divider(),
            const Text(
              '5. Apakah Clothify menyediakan pengembalian barang?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const Text(
                'Ya, Clothify menyediakan layanan pengembalian barang untuk produk yang rusak atau tidak sesuai deskripsi. Syarat dan ketentuan berlaku. Anda dapat mengajukan pengembalian barang melalui fitur "Pengembalian Barang" di halaman pesanan Anda.',
                textAlign: TextAlign.justify),
          ],
        ),
      ),
    );
  }
}
