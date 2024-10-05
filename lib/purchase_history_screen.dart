import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'order_details.dart';
import 'profile.dart';
import 'history_empty_screen.dart';
import 'product_item.dart';
import 'auth/login.dart';

class PurchaseHistoryScreen extends StatelessWidget {
  const PurchaseHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // Jika user tidak terautentikasi, redirect ke layar login
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      });
      return SizedBox();
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFFFF8F0),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Purchase History',
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
              Navigator.pop(
                  context, MaterialPageRoute(builder: (context) => Profile()));
            },
          ),
        ),
        body: Container(
          color: Color(0xFFFFF8F0),
          child: FutureBuilder<QuerySnapshot>(
            // Mengambil data dari firebase
            future: FirebaseFirestore.instance
                .collection('transactions')
                .where('user_id', isEqualTo: user.uid)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 146, 20, 12),
                ));
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HistoryEmptyScreen()),
                  );
                });
                return SizedBox();
              }

              var transactions = snapshot.data!.docs;

              // Menampilkan semua transaksi yang dilakukan user
              return ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  var transaction = transactions[index];
                  var transactionData =
                      transaction.data() as Map<String, dynamic>;

                  // Menampilkan data setiap transaksi
                  return PurchaseCard(
                    userId: user.uid,
                    date: (transactionData['date'] as Timestamp).toDate(),
                    storeName: transactionData['store_name'],
                    total: transactionData['total'],
                    transactionId: transaction.id,
                    products:
                        transaction.reference.collection('product_list').get(),
                  );
                },
              );
            },
          ),
        ));
  }
}

class PurchaseCard extends StatelessWidget {
  final String userId;
  final DateTime date;
  final String storeName;
  final int total;
  final String transactionId;
  final Future<QuerySnapshot> products;

  const PurchaseCard({
    super.key,
    required this.userId,
    required this.date,
    required this.storeName,
    required this.total,
    required this.transactionId,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    // format total transaksi
    String formatTotal = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    ).format(total);

    return InkWell(
      // jika diklik, redirect ke halaman order detail
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OrderDetailsScreen(
                    userId: userId,
                    transactionId: transactionId,
                    products: products,
                  )),
        );
      },
      child: Padding(
        padding: EdgeInsets.all(15.0),
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
                  Icon(Icons.store),
                  SizedBox(width: 5),
                  // Nama toko penjual
                  Text(
                    storeName,
                    style: GoogleFonts.urbanist(
                      textStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                  Spacer(),
                  // Tanggal transaksi
                  Text(
                    '${date.day}-${date.month}-${date.year}',
                    style: GoogleFonts.urbanist(
                      textStyle: TextStyle(color: Colors.grey.shade700),
                    ),
                  ),
                ],
              ),
              Divider(color: Color.fromARGB(255, 146, 20, 12), thickness: 1.5),
              // Mengambil data produk
              FutureBuilder<QuerySnapshot>(
                future: products,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(
                      color: Color.fromARGB(255, 146, 20, 12),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Text('No products found.');
                  }

                  var productDocs = snapshot.data!.docs;

                  // Menampilkan data setiap produk transaksi
                  return Column(
                    children: productDocs.expand((productDoc) {
                      var productData =
                          productDoc.data() as Map<String, dynamic>;

                      return [
                        SizedBox(height: 20),
                        ProductItem(
                          // redirect ke product_item.dart
                          quantity: productData['quantity'] ?? 1,
                          productId: productData['productid'] ?? 'unknown',
                        ),
                      ];
                    }).toList(),
                  );
                },
              ),
              SizedBox(height: 8),
              // harga transaksi
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  'Total  $formatTotal',
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
