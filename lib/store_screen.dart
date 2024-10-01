import 'package:flutter/material.dart';
import 'widgets/product_card.dart'; // Import ProductCard
import 'widgets/category_selector.dart'; // Import CategorySelector widget
import 'widgets/screen_title.dart';
import 'package:marketplace/model/product_model.dart'; // Import Product model
import 'package:marketplace/product_detail.dart'; // Import ProductDetailScreen
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  List<Product> products = []; // Daftar produk
  String selectedCategory = 'All'; // Kategori default

  @override
  void initState() {
    super.initState();
    fetchProducts(); // Ambil produk saat inisialisasi
  }

  Future<void> fetchProducts() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('products').get();
    setState(() {
      products = snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return Product(
          id: doc.id,
          name: data['name'],
          description: data['description'],
          image: data['image'],
          category: data['category'],
          storeName: data['storeName'],
          price: data['price'].toDouble(),
          rating: data['rating'].toString(),
        );
      }).toList();
    });
  }

  List<Product> get filteredProducts {
    if (selectedCategory == 'All') {
      return products;
    } else {
      return products
          .where((product) => product.category == selectedCategory)
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
                              ProductDetailScreen(productId: product.id),
                        ),
                      );
                    },
                    child: ProductCard(
                      name: product.name,
                      price: 'Rp ${product.price}',
                      rating: (product.rating),
                      imagePath: product.image,
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
