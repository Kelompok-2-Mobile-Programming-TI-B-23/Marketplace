import 'package:flutter/material.dart';
import 'package:marketplace/home_screen.dart';
import 'package:marketplace/search_screen.dart';
import 'widgets/product_card.dart';
import 'home_screen.dart';

class FilteredScreen extends StatefulWidget {
  final String category;
  final String gender;
  final String priceRange;
  final String productName;

  const FilteredScreen({
    super.key,
    required this.category,
    required this.gender,
    required this.priceRange,
    required this.productName,
  });

  @override
  State<FilteredScreen> createState() => _FilteredScreenState();
}

class _FilteredScreenState extends State<FilteredScreen> {
  bool _isAscending = true;

  final List<Map<String, dynamic>> products = [
    {
      'name': 'Loli',
      'price': '\$20',
      'rating': 4.5,
      'image': 'assets/product1.png',
      'category': 'Shirt',
      'gender': 'Male',
    },
    {
      'name': 'Milo',
      'price': '\$90',
      'rating': 4.0,
      'image': 'assets/product2.png',
      'category': 'Shirt',
      'gender': 'Female',
    },
    {
      'name': 'Alo',
      'price': '\$39',
      'rating': 4.3,
      'image': 'assets/product3.png',
      'category': 'Pants',
      'gender': 'Male',
    },
    {
      'name': 'Bingo',
      'price': '\$56',
      'rating': 4.3,
      'image': 'assets/product3.png',
      'category': 'Accessories',
      'gender': 'Male',
    },
    {
      'name': 'Lambo',
      'price': '\$50',
      'rating': 4.3,
      'image': 'assets/product3.png',
      'category': 'Accessories',
      'gender': 'Male',
    },
  ];

  List<Map<String, dynamic>> _filterProducts() {
    List<Map<String, dynamic>> filteredProducts = products.where((product) {
      bool matchesCategory =
          widget.category.isEmpty || product['category'] == widget.category;
      bool matchesGender = widget.gender.isEmpty ||
          (product['gender'] == 'Male' || product['gender'] == 'Female');
      bool matchesPriceRange = widget.priceRange.isEmpty ||
          _isProductInPriceRange(product['price'], widget.priceRange);
      bool matchesProductName = widget.productName.isEmpty ||
          product['name']
              .toLowerCase()
              .contains(widget.productName.toLowerCase());

      return matchesCategory &&
          matchesGender &&
          matchesPriceRange &&
          matchesProductName;
    }).toList();

    // Sort by name (A-Z or Z-A based on _isAscending)
    filteredProducts.sort((a, b) {
      return _isAscending
          ? a['name'].compareTo(b['name']) // Ascending (A-Z)
          : b['name'].compareTo(a['name']); // Descending (Z-A)
    });

    return filteredProducts;
  }

  bool _isProductInPriceRange(String productPrice, String priceRange) {
    if (priceRange.contains('-')) {
      double price =
          double.parse(productPrice.replaceAll(RegExp(r'[^0-9]'), ''));
      List<String> rangeParts = priceRange.replaceAll('\$', '').split(' - ');
      double minPrice = double.parse(rangeParts[0]);
      double maxPrice = double.parse(rangeParts[1]);
      return price >= minPrice && price <= maxPrice;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredProducts = _filterProducts();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF8F0),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 5),
            const Text(
              'Filtered Results',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF92140C),
              ),
            ),
          ],
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(5.0),
          child: Container(
            height: 5.0,
            color: Colors.transparent,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    if (widget.category.isNotEmpty)
                      _buildFilterItem('Category: ${widget.category}'),
                    if (widget.gender.isNotEmpty)
                      _buildFilterItem('Gender: ${widget.gender}'),
                    if (widget.priceRange.isNotEmpty)
                      _buildFilterItem('Price Range: ${widget.priceRange}'),
                    if (widget.productName.isNotEmpty)
                      _buildFilterItem('Product Name: ${widget.productName}'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
                    return ProductCard(
                      name: product['name'],
                      price: product['price'],
                      rating: product['rating'],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterItem(String text) {
    return Container(
      margin: const EdgeInsets.only(right: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF92140C)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }
}
