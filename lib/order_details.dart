import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'product_item.dart';

class OrderDetailsScreen extends StatelessWidget {
  final String userId;
  final String transactionId;
  final Future<QuerySnapshot<Object?>> products;

  const OrderDetailsScreen({
    super.key,
    required this.userId,
    required this.transactionId,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF8F0),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFF8F0),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Order Details',
          style: GoogleFonts.urbanist(
            textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ),
        // redirect balik ke halaman sebelumnya
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<DocumentSnapshot>(
          future:
              // Mengambil data pembeli
              FirebaseFirestore.instance.collection('users').doc(userId).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: Color.fromARGB(255, 146, 20, 12),
              ));
            }

            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              return Center(child: Text("No user data found"));
            }

            var userData = snapshot.data!.data() as Map<String, dynamic>;
            var address = userData['address'] ?? 'No address provided';

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      // alamat pembeli
                      Padding(
                        padding: EdgeInsets.only(left: 35.0),
                        child: Text(
                          address,
                          style: GoogleFonts.urbanist(
                            textStyle: TextStyle(color: Colors.grey.shade700),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
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
                      // Mengambil data produk dari firebase
                      FutureBuilder<QuerySnapshot>(
                        future: products,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator(
                              color: Color.fromARGB(255, 146, 20, 12),
                            );
                          }
                          if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return Text('No products found.');
                          }

                          var productDocs = snapshot.data!.docs;

                          // menampilkan data setiap produk transaksi
                          return Column(
                            children: productDocs.expand((productDoc) {
                              var productData =
                                  productDoc.data() as Map<String, dynamic>;

                              return [
                                SizedBox(height: 10),
                                ProductItem(
                                  // redirect ke product_item.dart
                                  quantity: productData['quantity'] ?? 0,
                                  productId:
                                      productData['productid'] ?? 'unknown',
                                ),
                                SizedBox(height: 10),
                                Divider(),
                              ];
                            }).toList(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                // menampilkan detail pembayaran transaksi
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('transactions')
                        .doc(transactionId)
                        .get(),
                    builder: (context, transactionSnapshot) {
                      if (transactionSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                            child: CircularProgressIndicator(
                          color: Color.fromARGB(255, 146, 20, 12),
                        ));
                      }

                      if (transactionSnapshot.hasError) {
                        return Center(
                            child: Text("Error: ${transactionSnapshot.error}"));
                      }

                      if (!transactionSnapshot.hasData ||
                          !transactionSnapshot.data!.exists) {
                        return Center(child: Text("No transaction data found"));
                      }

                      // deklarasi variabel
                      var transactionData = transactionSnapshot.data!.data()
                          as Map<String, dynamic>;
                      var subTotal = transactionData['sub_total'] ?? '0';
                      var deliveryFee = transactionData['delivery_fee'] ?? '0';
                      var totalCost = transactionData['total'] ?? '0';

                      // format semua harga
                      String formatSubTotal = NumberFormat.currency(
                        locale: 'id_ID',
                        symbol: 'Rp',
                        decimalDigits: 0,
                      ).format(subTotal);

                      String formatDeliveryFee = NumberFormat.currency(
                        locale: 'id_ID',
                        symbol: 'Rp',
                        decimalDigits: 0,
                      ).format(deliveryFee);

                      String formatTotal = NumberFormat.currency(
                        locale: 'id_ID',
                        symbol: 'Rp',
                        decimalDigits: 0,
                      ).format(totalCost);

                      return Container(
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
                            // metode pembayaran
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
                                      fontSize: 17,
                                    ),
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
                            // subtotal transaksi
                            Row(
                              children: [
                                Text(
                                  'Sub-Total',
                                  style: GoogleFonts.urbanist(
                                    textStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  formatSubTotal,
                                  style: GoogleFonts.urbanist(),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            // ongkos kirim
                            Row(
                              children: [
                                Text(
                                  'Delivery Fee',
                                  style: GoogleFonts.urbanist(
                                    textStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  formatDeliveryFee,
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
                            // total transaksi
                            Row(
                              children: [
                                Text(
                                  'Total Cost',
                                  style: GoogleFonts.urbanist(
                                    textStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  formatTotal,
                                  style: GoogleFonts.urbanist(),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
