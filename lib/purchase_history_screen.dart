// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketplace/profile.dart';

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
          "assets/images/clothify_red_no_back.png",
          width: 150,
        ),
        leading: IconButton(
          icon: Icon(CupertinoIcons.back, color: Colors.black),
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
              Column(
                children: List.generate(5, (index) {
                  // masih sementara
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
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.grey, width: 1),
      ),
      color: Color(0xFFFFF8F0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.all(1.0),
              leading: Container(
                // replace with store picture
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              title: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align to the left
                children: [
                  Text(
                    'Purchase',
                    style: GoogleFonts.urbanist(
                      textStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    date,
                    style: GoogleFonts.urbanist(
                      textStyle: TextStyle(color: Colors.grey.shade700),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Column(
              children: List.generate(2, (index) {
                // masih sementara
                return Column(
                  children: const [
                    SizedBox(height: 16),
                    ProductItem(),
                  ],
                );
              }, growable: false),
            ),
            SizedBox(height: 8),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                'Total - \$0.00',
                style: GoogleFonts.urbanist(
                  textStyle: TextStyle(color: Color(0xFF92104C), fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          // replace with product picture
          width: 68,
          height: 68,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama Produk',
              style: GoogleFonts.urbanist(
                textStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              'Category',
              style: GoogleFonts.urbanist(
                textStyle: TextStyle(color: Colors.grey.shade700),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Harga',
              style: GoogleFonts.urbanist(
                textStyle: TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
