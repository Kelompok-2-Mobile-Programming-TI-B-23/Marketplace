import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 248, 240),
      appBar: AppBar(
        title: Text(
          'Privacy Policy',
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
                'Clothify menghormati dan melindungi privasi semua pengguna kami. Kebijakan privasi ini menjelaskan bagaimana kami mengumpulkan, menggunakan, dan melindungi informasi pribadi Anda saat Anda menggunakan aplikasi Clothify. Dengan menggunakan aplikasi kami, Anda menyetujui pengumpulan dan penggunaan informasi sesuai dengan kebijakan ini.',
                textAlign: TextAlign.justify),
            const SizedBox(height: 16),
            const Text(
              'Pengumpulan Informasi',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text(
                'Kami mengumpulkan informasi pribadi yang Anda berikan secara sukarela, seperti nama, alamat email, nomor telepon, dan informasi pembayaran saat Anda mendaftar atau melakukan transaksi di Clothify. Kami juga dapat mengumpulkan informasi perangkat dan data lokasi untuk meningkatkan pengalaman pengguna.',
                textAlign: TextAlign.justify),
            const SizedBox(height: 16),
            const Text(
              'Penggunaan Informasi',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text(
                'Informasi pribadi Anda digunakan untuk memproses pesanan, memberikan layanan pelanggan, mengirim pemberitahuan terkait akun, serta menawarkan promosi dan diskon yang relevan. Kami tidak akan membagikan informasi pribadi Anda kepada pihak ketiga tanpa persetujuan Anda, kecuali diwajibkan oleh hukum.',
                textAlign: TextAlign.justify),
            const SizedBox(height: 16),
            const Text(
              'Keamanan Informasi',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text(
                'Kami menggunakan langkah-langkah keamanan yang sesuai untuk melindungi informasi pribadi Anda dari akses yang tidak sah, penggunaan, atau pengungkapan. Namun, tidak ada metode transmisi data melalui internet yang sepenuhnya aman, sehingga kami tidak dapat menjamin keamanan absolut.',
                textAlign: TextAlign.justify),
            const SizedBox(height: 16),
            const Text(
              'Perubahan Kebijakan',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text(
                'Kami berhak memperbarui kebijakan privasi ini kapan saja. Setiap perubahan akan diberitahukan melalui aplikasi atau email Anda.',
                textAlign: TextAlign.justify),
          ],
        ),
      ),
    );
  }
}
