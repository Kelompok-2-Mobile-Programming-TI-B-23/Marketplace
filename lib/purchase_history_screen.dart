// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'order_details.dart';
import 'profile.dart';
import 'history_empty_screen.dart';
import 'product_item.dart';

class PurchaseHistoryScreen extends StatelessWidget {
  const PurchaseHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

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
            future: FirebaseFirestore.instance
                .collection('transactions')
                .where('user_id', isEqualTo: user?.uid)
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

              return ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  var transaction = transactions[index];
                  var transactionData =
                      transaction.data() as Map<String, dynamic>;

                  return PurchaseCard(
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
  final DateTime date;
  final String storeName;
  final int total;
  final String transactionId;
  final Future<QuerySnapshot> products;

  const PurchaseCard({
    super.key,
    required this.date,
    required this.storeName,
    required this.total,
    required this.transactionId,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OrderDetailsScreen(
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
                  Text(
                    storeName,
                    style: GoogleFonts.urbanist(
                      textStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                  Spacer(),
                  Text(
                    '${date.day}-${date.month}-${date.year}',
                    style: GoogleFonts.urbanist(
                      textStyle: TextStyle(color: Colors.grey.shade700),
                    ),
                  ),
                ],
              ),
              Divider(color: Color.fromARGB(255, 146, 20, 12), thickness: 1.5),
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

                  return Column(
                    children: productDocs.expand((productDoc) {
                      var productData =
                          productDoc.data() as Map<String, dynamic>;

                      return [
                        SizedBox(height: 20),
                        ProductItem(
                          quantity: productData['quantity'] ?? 1,
                          productId: productData['productid'] ?? 'unknown',
                        ),
                      ];
                    }).toList(),
                  );
                },
              ),
              SizedBox(height: 8),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  'Total  Rp$total',
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
