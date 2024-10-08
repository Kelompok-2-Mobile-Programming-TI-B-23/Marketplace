import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'product_detail.dart';

class ProductItem extends StatelessWidget {
  final String productId;
  final int quantity;

  const ProductItem({
    super.key,
    required this.quantity,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    // Mengambil data dari firebase
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
            color: Color.fromARGB(255, 146, 20, 12),
          ));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || !snapshot.data!.exists) {
          return Center(child: Text('Product not found'));
        }

        // Deklarasi variabel
        var productData = snapshot.data!.data() as Map<String, dynamic>;
        String productName = productData['name'] ?? 'Unknown Product';
        String category = productData['category'] ?? 'Unknown Category';
        int price = (productData['price'] ?? 0) as int;
        String productImage = productData['image'];

        // Format harga produk
        String formattedPrice = NumberFormat.currency(
          locale: 'id_ID',
          symbol: 'Rp',
          decimalDigits: 0,
        ).format(price);

        return GestureDetector(
          // Jika diklik, redirect ke halaman product detail
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailScreen(productId: productId),
              ),
            );
          },
          child: Row(
            children: [
              // Gambar produk
              Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(productImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Nama produk
                        Text(
                          productName,
                          style: GoogleFonts.urbanist(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 146, 20, 12)),
                          ),
                        ),
                        Spacer(),
                        // Jumlah produk yang dibeli
                        Text(
                          'x$quantity',
                          style: GoogleFonts.urbanist(
                            textStyle: TextStyle(color: Colors.grey.shade700),
                          ),
                        ),
                      ],
                    ),
                    // Kategori produk
                    Text(
                      category,
                      style: GoogleFonts.urbanist(
                        textStyle: TextStyle(color: Colors.grey.shade700),
                      ),
                    ),
                    SizedBox(height: 8),
                    // harga produk
                    Text(
                      formattedPrice,
                      style: GoogleFonts.urbanist(
                        textStyle: TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
