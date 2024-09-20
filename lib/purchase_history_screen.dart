// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketplace/order_details.dart';
import 'package:marketplace/profile.dart';
import 'package:marketplace/product_item.dart';

class PurchaseHistoryScreen extends StatelessWidget {
  const PurchaseHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFF8F0),
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          // Logo Marketplace
          "assets/images/clothify_red_no_back.png",
          width: 150,
        ),
        leading: IconButton(
          // tombol back ke profile
          icon: Icon(Icons.arrow_back_rounded, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Profile()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFFFFF8F0),
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 5),
              Text(
                // Tulisan Judul Page (purchase history)
                'Purchase History',
                style: GoogleFonts.urbanist(
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 16),
              // menampilkan riwayat transaksi pembeli
              Column(
                children: List.generate(3, (index) {
                  return Column(
                    children: const [
                      SizedBox(height: 16),
                      PurchaseCard(date: 'Jun 10, 2024'),
                    ],
                  );
                }, growable: false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PurchaseCard extends StatelessWidget {
  final String date;

  const PurchaseCard({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // redirect ke halaman order details
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OrderDetailsScreen()),
        );
      },
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: Color.fromARGB(100, 255, 255, 255),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.store),
                  SizedBox(width: 5),
                  Text(
                    // nama toko
                    'Store Name',
                    style: GoogleFonts.urbanist(
                      textStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                  Spacer(),
                  Text(
                    // tanggal transaksi
                    date,
                    style: GoogleFonts.urbanist(
                      textStyle: TextStyle(color: Colors.grey.shade700),
                    ),
                  ),
                ],
              ),
              Divider(
                color: Color.fromARGB(255, 146, 20, 12),
                thickness: 1.5,
              ),
              Column(
                children: List.generate(2, (index) {
                  return Column(
                    children: const [
                      SizedBox(height: 16),
                      ProductItem(), // menampilkan detail setiap barang transaksi
                    ],
                  );
                }, growable: false),
              ),
              SizedBox(height: 8),
              Align(
                // menampilkan total transaksi
                alignment: Alignment.bottomRight,
                child: Text(
                  'Total - \$0.00',
                  style: GoogleFonts.urbanist(
                    textStyle: TextStyle(
                        color: Color.fromARGB(255, 146, 20, 12),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
