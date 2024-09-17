// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketplace/product_item.dart';
import 'package:marketplace/purchase_history_screen.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF8F0),
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
              MaterialPageRoute(builder: (context) => PurchaseHistoryScreen()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5),
            Center(
              child: Text(
                'Order Details',
                style: GoogleFonts.urbanist(
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Shipping Address',
                    style: GoogleFonts.urbanist(
                      textStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Text(
                    'address',
                    style: GoogleFonts.urbanist(
                      textStyle: TextStyle(color: Colors.grey.shade700),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Order List',
                    style: GoogleFonts.urbanist(
                      textStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Column(
                    children: List.generate(3, (index) {
                      // Placeholder ProductItem, you can replace it with real data later
                      return Column(
                        children: const [
                          SizedBox(height: 10),
                          ProductItem(),
                          SizedBox(height: 10),
                          Divider(),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
