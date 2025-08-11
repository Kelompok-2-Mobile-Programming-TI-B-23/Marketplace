import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:marketplace/product_detail.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  // Mengambil data di firebase
  Future<List<QueryDocumentSnapshot>> _getProducts() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('products')
        .where('storeName', isEqualTo: 'Angel Store')
        .get();
    return querySnapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<QueryDocumentSnapshot>>(
      future: _getProducts(),
      builder: (context, snapshot) {
        // icon loading progress
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
            color: Color.fromARGB(255, 146, 20, 12),
          ));
        }
        // jika tidak ditemukan data di database
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              'No Products Found',
              style: GoogleFonts.urbanist(
                  textStyle:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          );
        }

        var products = snapshot.data!;

        // Menampilkan list produk
        return Column(
          children: products.map((product) {
            return Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  SizedBox(height: 5),
                  // menampilkan setiap produk
                  ProductCard(
                    productId: product.id,
                  ),
                  Divider(),
                  SizedBox(height: 5),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  final String productId;

  const ProductCard({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    // mengambil data setiap produk di firebase
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
          // untuk setiap tampilan produk, di redirect ke halaman product detail
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
                    // Nama produk
                    Text(
                      productName,
                      style: GoogleFonts.urbanist(
                        textStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 146, 20, 12)),
                      ),
                    ),
                    // Kategori produk
                    Text(
                      category,
                      style: GoogleFonts.urbanist(
                        textStyle: TextStyle(color: Colors.grey.shade700),
                      ),
                    ),
                    SizedBox(height: 8),
                    // Harga produk
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
