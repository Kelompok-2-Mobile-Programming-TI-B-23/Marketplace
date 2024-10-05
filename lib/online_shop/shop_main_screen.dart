import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'transaction_list.dart';
import 'product_list.dart';

// Halaman Toko
// disetel hanya untuk toko 'Angel Store' karena keterbatasan waktu

class ShopMainScreen extends StatelessWidget {
  const ShopMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF8F0),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFF8F0),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Angel Store', // Nama Toko
          style: GoogleFonts.urbanist(
            textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        // Redirect balik ke Profile
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFFFFF8F0),
          child: Column(
            children: [
              // Dummy Saldo Toko
              Padding(
                padding:
                    EdgeInsets.only(left: 90, right: 90, top: 15, bottom: 15),
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
                        children: [
                          Icon(Icons.account_balance_wallet_outlined,
                              color: Colors.black),
                          SizedBox(width: 5),
                          Text(
                            'Store Balance',
                            style: GoogleFonts.urbanist(
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(width: 30),
                          Text(
                            'Rp1.000.000',
                            style: GoogleFonts.urbanist(color: Colors.black),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              // Menampilkan list produk yang dijual toko
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Product List',
                    style: GoogleFonts.urbanist(
                      textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ProductList(), // list produk diteruskan ke product_list.dart
              SizedBox(height: 20),

              // Menampilkan list transaksi toko
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Transaction List',
                    style: GoogleFonts.urbanist(
                      textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              TransactionList(), // list transaksi diteruskan ke transaction_list.dart
            ],
          ),
        ),
      ),
    );
  }
}
