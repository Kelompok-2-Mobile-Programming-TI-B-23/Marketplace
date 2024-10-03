import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marketplace/homepage.dart';
import 'package:marketplace/product_detail.dart';
import 'widgets/product_card.dart'; // Import the ProductCard widget

class SearchPage extends StatelessWidget {
  final String selectedSuggestion;

  const SearchPage({super.key, required this.selectedSuggestion});

  Future<List<Map<String, dynamic>>> fetchProducts(String query) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('products')
        .where('name', isEqualTo: query)
        .get();

    // Debugging: Print the fetched documents
    print('Fetched products: ${snapshot.docs.map((doc) => doc.data())}');

    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return {
        'name': data['name'],
        'price': (data['price'] is String)
            ? double.tryParse(data['price']) ?? 0.0 // Handle String prices
            : (data['price'] as num).toDouble(), // Ensure it's a double
        'rating': (data['rating'] is String)
            ? double.tryParse(data['rating']) ?? 0.0 // Handle String ratings
            : (data['rating'] as num).toDouble(),
        'image': data['image'] ?? 'https://via.placeholder.com/150',
        'id': doc.id // Add the document ID for navigation
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF8F0),
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: const Color(0xFFFFF8F0),
          leading: Padding(
            padding: const EdgeInsets.only(top: 30, left: 20),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_rounded, color: Colors.black),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomepageScreen()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ),
          title: const Column(
            children: [
              const SizedBox(height: 30),
              const Text(
                'Product Search Results',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ],
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(5.0),
            child: Container(
              height: 5.0,
              color: Colors.transparent,
            ),
          ),
        ),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: fetchProducts(selectedSuggestion),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error fetching products'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No products found'));
            }

            final products = snapshot.data!;
            // Debugging: Print the list of products
            print('Products: $products');

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.75,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  // Debugging: Print the product details
                  print(
                      'Product: ${product['name']}, Image: ${product['image']}');

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(
                              productId: product['id']), // Use the ID here
                        ),
                      );
                    },
                    child: ProductCard(
                      name: product['name'],
                      price:
                          'Rp ${product['price'].toStringAsFixed(0)}', // Format price to string
                      rating: product['rating'],
                      imagePath: product['image'],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
