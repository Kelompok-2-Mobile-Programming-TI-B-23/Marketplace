// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
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
        title: Text(
          // Tulisan Judul Page (purchase history)
          'Order Details',
          style: GoogleFonts.urbanist(
            textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ),
        leading: IconButton(
          // Tombol Back ke purchase history
          icon: Icon(Icons.arrow_back_rounded, color: Colors.black),
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
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Alamat pengiriman
                  Row(
                    children: [
                      Icon(Icons.location_on_sharp),
                      SizedBox(width: 10),
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
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 35.0),
                    child: Text(
                      'address',
                      style: GoogleFonts.urbanist(
                        textStyle: TextStyle(color: Colors.grey.shade700),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // List barang yg dibeli
                  Row(
                    children: [
                      Icon(Icons.view_list_rounded),
                      SizedBox(width: 10),
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
                    ],
                  ),
                  SizedBox(height: 10),
                  Column(
                    children: List.generate(3, (index) {
                      return Column(
                        children: const [
                          SizedBox(height: 10),
                          ProductItem(), // menampilkan detail setiap barang transaksi
                          SizedBox(height: 10),
                          Divider(),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(100, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.account_balance_wallet_outlined),
                        SizedBox(width: 5),
                        Text(
                          'Payment Method',
                          style: GoogleFonts.urbanist(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                        ),
                        Spacer(),
                        Text(
                          'e-wallet',
                          style: GoogleFonts.urbanist(),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          'Sub-Total',
                          style: GoogleFonts.urbanist(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Spacer(),
                        Text(
                          '0.00',
                          style: GoogleFonts.urbanist(),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Delivery Fee',
                          style: GoogleFonts.urbanist(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Spacer(),
                        Text(
                          '0.00',
                          style: GoogleFonts.urbanist(),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider(
                      color: Color.fromARGB(255, 146, 20, 12),
                      thickness: 1.5,
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Total Cost',
                          style: GoogleFonts.urbanist(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Spacer(),
                        Text(
                          '0.00',
                          style: GoogleFonts.urbanist(),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
