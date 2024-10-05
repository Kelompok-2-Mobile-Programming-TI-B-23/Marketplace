// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:marketplace/product_item.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  Future<List<QueryDocumentSnapshot>> _getTransactions() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('transactions')
        .where('store_name', isEqualTo: 'Angel Store')
        .get();
    return querySnapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<QueryDocumentSnapshot>>(
      future: _getTransactions(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
            color: Color.fromARGB(255, 146, 20, 12),
          ));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              'No Transaction Yet',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          );
        }

        var transactions = snapshot.data!;

        return Column(
          children: transactions.map((transaction) {
            var transactionData = transaction.data() as Map<String, dynamic>;

            return TransactionCard(
              date: (transactionData['date'] as Timestamp).toDate(),
              userId: transactionData['user_id'],
              total: transactionData['total'],
              transactionId: transaction.id,
              products: transaction.reference.collection('product_list').get(),
            );
          }).toList(),
        );
      },
    );
  }
}

class TransactionCard extends StatelessWidget {
  final DateTime date;
  final String userId;
  final int total;
  final String transactionId;
  final Future<QuerySnapshot> products;

  const TransactionCard({
    super.key,
    required this.date,
    required this.userId,
    required this.total,
    required this.transactionId,
    required this.products,
  });

  Future<String> _getUserName() async {
    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (userSnapshot.exists) {
      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;
      return userData['username'] ?? 'Unknown User';
    }
    return 'Unknown User';
  }

  @override
  Widget build(BuildContext context) {
    String formatTotal = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    ).format(total);

    return Padding(
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
                FutureBuilder<String>(
                  future: _getUserName(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(
                        color: Color.fromARGB(255, 146, 20, 12),
                      );
                    }
                    if (snapshot.hasError) {
                      return Text('Error');
                    }

                    return Text(
                      snapshot.data ?? 'Unknown User',
                      style: GoogleFonts.urbanist(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    );
                  },
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
                    var productData = productDoc.data() as Map<String, dynamic>;

                    return [
                      SizedBox(height: 20),
                      ProductItem(
                        quantity: productData['quantity'] ?? 0,
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
    );
  }
}
