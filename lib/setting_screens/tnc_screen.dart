import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 248, 240),
      appBar: AppBar(
          title: Text(
            'Terms & Conditions',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 255, 248, 240),
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Terms & Conditions',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 16),
            const Text(
                'Selamat datang di Clothify. Dengan menggunakan aplikasi kami, Anda menyetujui untuk terikat oleh syarat dan ketentuan berikut ini. Jika Anda tidak menyetujui salah satu dari ketentuan ini, Anda tidak diperbolehkan menggunakan aplikasi kami.',
                textAlign: TextAlign.justify),
            const SizedBox(height: 16),
            const Text(
              'Penggunaan Layanan',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text(
                'Anda harus berusia minimal 18 tahun untuk dapat menggunakan aplikasi Clothify. Penggunaan akun harus sesuai dengan peraturan yang berlaku dan Anda bertanggung jawab penuh atas aktivitas yang terjadi di akun Anda.',
                textAlign: TextAlign.justify),
            const SizedBox(height: 16),
            const Text(
              'Transaksi dan Pembayaran',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text(
                'Semua transaksi di Clothify diproses dengan metode pembayaran yang aman. Kami tidak bertanggung jawab atas transaksi di luar platform kami.',
                textAlign: TextAlign.justify),
            const SizedBox(height: 16),
            const Text(
              'Pengembalian dan Penukaran',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text(
                'Pengembalian atau penukaran barang dapat dilakukan dalam jangka waktu 7 hari setelah penerimaan, dengan syarat produk masih dalam kondisi asli. Biaya pengiriman ditanggung oleh pembeli kecuali barang yang diterima rusak atau salah.',
                textAlign: TextAlign.justify),
            const SizedBox(height: 16),
            const Text(
              'Perubahan Syarat & Ketentuan',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text(
                'Clothify berhak mengubah syarat dan ketentuan ini kapan saja. Kami akan memberi tahu Anda tentang perubahan melalui notifikasi di aplikasi.',
                textAlign: TextAlign.justify),
          ],
        ),
      ),
    );
  }
}
