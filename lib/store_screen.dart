import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/product_card.dart'; // Import ProductCard
import 'widgets/clothify_logo.dart';
import 'widgets/category_selector.dart'; // Import CategorySelector widget
import 'widgets/page_title.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  String selectedCategory = 'All'; // Kategori default

  // Data produk
  final List<Map<String, dynamic>> allProducts = [
    {
      'name': 'T-Shirt 1',
      'category': 'T-Shirt',
      'price': 'Rp 100.000',
      'rating': 4.5,
      'image': 'assets/images/shoes.jpg'
    },
    {
      'name': 'T-Shirt 2',
      'category': 'T-Shirt',
      'price': 'Rp 150.000',
      'rating': 4.0,
      'image': 'assets/images/shoes.jpg'
    },
    {
      'name': 'Pants 1',
      'category': 'Pants',
      'price': 'Rp 200.000',
      'rating': 3.5,
      'image': 'assets/images/shoes.jpg'
    },
    {
      'name': 'Shoes 1',
      'category': 'Shoes',
      'price': 'Rp 300.000',
      'rating': 5.0,
      'image': 'assets/images/shoes.jpg'
    },
    {
      'name': 'Accessory 1',
      'category': 'Accessory',
      'price': 'Rp 50.000',
      'rating': 3.0,
      'image': 'assets/images/shoes.jpg'
    },
  ];

  // Kategori produk
  final List<String> categories = [
    'All',
    'T-Shirt',
    'Pants',
    'Shoes',
    'Accessory'
  ];

  // Mengambil produk berdasarkan kategori
  List<Map<String, dynamic>> get filteredProducts {
    if (selectedCategory == 'All') {
      return allProducts;
    } else {
      return allProducts
          .where((product) => product['category'] == selectedCategory)
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScreenTitle(title: "Store"),

            const SizedBox(height: 20),

            // Widget CategorySelector
            CategorySelector(
              categories: categories,
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
                return ProductCard(
                  name: product['name'],
                  price: product['price'],
                  rating: product['rating'],
                  imagePath: product['image'],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
