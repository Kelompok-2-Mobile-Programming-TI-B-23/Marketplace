import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:marketplace/product_detail.dart';
import 'package:marketplace/widgets/product_card.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({Key? key}) : super(key: key);

  Future<List<Map<String, dynamic>>> fetchProducts() async {
    final List<Map<String, dynamic>> selectedProducts = [];
    final categories = ['Clothes', 'Pants', 'Accessories', 'Shoes'];

    try {
      for (String category in categories) {
        final QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('products')
            .where('category', isEqualTo: category)
            .limit(1) // Get only one item per category
            .get();

        if (snapshot.docs.isNotEmpty) {
          var data = snapshot.docs.first.data() as Map<String, dynamic>;

          // Handle price conversion
          double price = 0.0;
          if (data['price'] is int) {
            price = (data['price'] as int).toDouble();
          } else if (data['price'] is double) {
            price = data['price'];
          } else if (data['price'] is String) {
            price = double.tryParse(data['price']) ?? 0.0;
          }

          selectedProducts.add({
            'id': snapshot.docs.first.id,
            'name': data['name'] ?? 'No Name',
            'price': price,
            'rating': (data['rating'] is double)
                ? data['rating'].toString()
                : (data['rating'] is int
                    ? (data['rating'] as int).toDouble().toString()
                    : '0.0'),
            'image': data['image'] ?? 'https://via.placeholder.com/150',
          });
        }
      }
    } catch (e) {
      print("Error fetching products: $e");
    }

    return selectedProducts;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 300,
            child: Center(
              child: CircularProgressIndicator(
                color: const Color.fromARGB(255, 146, 20, 12),
              ),
            ),
          );
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return const Center(
            child: const Text('Error fetching products'),
          );
        }

        final selectedProducts = snapshot.data ?? [];

        return GridView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 3 / 4,
          ),
          itemCount: selectedProducts.length,
          itemBuilder: (context, index) {
            final item = selectedProducts[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProductDetailScreen(productId: item['id']),
                  ),
                );
              },
              child: ProductCard(
                name: item['name'],
                price:
                    'Rp ${NumberFormat('#,###', 'id_ID').format(item['price'])}',
                rating: double.parse(item['rating']),
                imagePath: item['image'],
              ),
            );
          },
        );
      },
    );
  }
}
