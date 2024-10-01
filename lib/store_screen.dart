import 'package:flutter/material.dart';
import 'widgets/product_card.dart'; // Import ProductCard
import 'widgets/category_selector.dart'; // Import CategorySelector widget
import 'widgets/screen_title.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:marketplace/product_detail.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  List<Map<String, dynamic>> products = []; // List of products as Map
  String selectedCategory = 'All'; // Default category

  @override
  void initState() {
    super.initState();
    fetchProducts(); // Fetch products on initialization
  }

  Future<void> fetchProducts() async {
    try {
      final QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('products').get();
      setState(() {
        products = snapshot.docs.map((doc) {
          return {
            'id': doc.id,
            'name': doc['name'],
            'description': doc['description'],
            'image': doc['image'],
            'category': doc['category'],
            'storeName': doc['storeName'],
            'price': (doc['price'] is double)
                ? doc['price']
                : (doc['price'] is int
                    ? (doc['price'] as int).toDouble()
                    : 0.0),
            'rating': (doc['rating'] is double)
                ? doc['rating']
                : (doc['rating'] is int
                    ? (doc['rating'] as int).toDouble()
                    : 0.0),
          };
        }).toList();
      });
    } catch (e) {
      print("Error fetching products: $e");
    }
  }

  List<Map<String, dynamic>> get filteredProducts {
    if (selectedCategory == 'All') {
      return products;
    } else {
      return products
          .where((product) => product['category'] == selectedCategory)
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 248, 240),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ScreenTitle(title: "Store"),
              const SizedBox(height: 20),

              // Widget CategorySelector
              CategorySelector(
                categories: ['All', 'Clothes', 'Pants', 'Shoes', 'Accessories'],
                selectedCategory: selectedCategory,
                onCategorySelected: (String category) {
                  setState(() {
                    selectedCategory = category;
                  });
                },
              ),
              const SizedBox(height: 20),

              // Product Grid
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3 / 4,
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailScreen(productId: product['id']),
                        ),
                      );
                    },
                    child: ProductCard(
                      name: product['name'],
                      price: 'Rp ${product['price'].toString()}',
                      rating: product['rating'],
                      imagePath: product['image'],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
