import 'package:flutter/material.dart';
import 'widgets/product_card.dart';
import 'widgets/category_selector.dart';
import 'widgets/screen_title.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marketplace/product_detail.dart';
import 'package:intl/intl.dart';

class FilterSort extends StatefulWidget {
  const FilterSort({super.key});

  @override
  _FilterSortState createState() => _FilterSortState();
}

class _FilterSortState extends State<FilterSort> {
  String selectedCategory = 'All';
  bool _isPriceAscending = true;
  bool _isNameAscending = true;
  bool _sortByPrice = false;

  // Method to filter products based on selected category
  List<Map<String, dynamic>> filterProducts(
      List<Map<String, dynamic>> products) {
    List<Map<String, dynamic>> filtered = selectedCategory == 'All'
        ? products
        : products
            .where((product) => product['category'] == selectedCategory)
            .toList();

    // Apply sorting based on the selected sorting method
    if (_sortByPrice) {
      filtered.sort((a, b) => _isPriceAscending
          ? a['price'].compareTo(b['price'])
          : b['price'].compareTo(a['price']));
    } else {
      filtered.sort((a, b) => _isNameAscending
          ? a['name'].compareTo(b['name'])
          : b['name'].compareTo(a['name']));
    }

    return filtered;
  }

  void _togglePriceSorting() {
    setState(() {
      _sortByPrice = true;
      _isPriceAscending = !_isPriceAscending;
    });
  }

  void _toggleNameSorting() {
    setState(() {
      _sortByPrice = false;
      _isNameAscending = !_isNameAscending;
    });
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
              const SizedBox(height: 20),
              const ScreenTitle(title: "Filter & Sort"),
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

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Sort by Price Button
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: _togglePriceSorting,
                      child: Row(
                        children: [
                          const Text(
                            'Sort by Price',
                            style: TextStyle(
                              color: Color(0xFF92140C),
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Icon(
                            _isPriceAscending
                                ? Icons.arrow_upward
                                : Icons.arrow_downward,
                            color: Color(0xFF92140C),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Sort by Name Button
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: _toggleNameSorting,
                      child: Row(
                        children: [
                          const Text(
                            'Sort by Name',
                            style: TextStyle(
                              color: Color(0xFF92140C),
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Icon(
                            _isNameAscending
                                ? Icons.arrow_upward
                                : Icons.arrow_downward,
                            color: Color(0xFF92140C),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // StreamBuilder to fetch products in real-time
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('products')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(
                      height: 500,
                      child: Center(
                        child: CircularProgressIndicator(
                            color: Color.fromARGB(255, 146, 20, 12)),
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return const Center(
                      child: const Text('Error fetching products'),
                    );
                  }

                  // Extract product data from snapshot
                  final List<Map<String, dynamic>> products =
                      snapshot.data!.docs.map((doc) {
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

                  final filteredProducts = filterProducts(products);

                  // Display the product grid
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                          price:
                              'Rp ${NumberFormat('#,###', 'id_ID').format(product['price'])}',
                          rating: product['rating'],
                          imagePath: product['image'],
                        ),
                      );
                    },
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
