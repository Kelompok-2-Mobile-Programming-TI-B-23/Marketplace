import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marketplace/homepage.dart';
import 'widgets/product_card.dart';

class FilteredScreen extends StatefulWidget {
  final String category;
  final String priceRange;
  final String productName;

  const FilteredScreen({
    Key? key,
    required this.category,
    required this.priceRange,
    required this.productName,
  }) : super(key: key);

  @override
  State<FilteredScreen> createState() => _FilteredScreenState();
}

class _FilteredScreenState extends State<FilteredScreen> {
  String? _activeSort; // To track the active sorting criterion
  bool _isAscending = true; // To track sorting order
  List<Map<String, dynamic>> products = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    Query query = FirebaseFirestore.instance.collection('products');

    // Apply filters based on selected category
    if (widget.category.isNotEmpty) {
      query = query.where('category', isEqualTo: widget.category);
    }

    // Apply sorting based on the active sort criterion
    if (_activeSort == 'price') {
      query = query.orderBy('price', descending: !_isAscending);
    } else if (_activeSort == 'name') {
      query = query.orderBy('name', descending: !_isAscending);
    }

    // Fetch the data
    final querySnapshot = await query.get();
    setState(() {
      products = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          'name': data['name'],
          'price': (data['price'] is String)
              ? double.tryParse(data['price']) ?? 0.0 // Handle String prices
              : (data['price'] as num).toDouble(), // Ensure it's a double
          'rating': (data['rating'] is String)
              ? double.tryParse(data['rating']) ?? 0.0 // Handle String ratings
              : (data['rating'] as num).toDouble(),
          'image': data['image'],
          'category': data['category'],
        };
      }).toList();
    });
  }

  List<Map<String, dynamic>> _filterProducts() {
    // Apply filters
    List<Map<String, dynamic>> filteredProducts = products.where((product) {
      bool matchesPriceRange = widget.priceRange.isEmpty ||
          _isProductInPriceRange(
              product['price'].toString(), widget.priceRange);
      bool matchesProductName = widget.productName.isEmpty ||
          product['name']
              .toLowerCase()
              .contains(widget.productName.toLowerCase());

      return matchesPriceRange && matchesProductName;
    }).toList();

    // Sort filtered products
    if (_activeSort == 'price') {
      filteredProducts.sort((a, b) => _isAscending
          ? a['price'].compareTo(b['price']) // Ascending (Low to High)
          : b['price'].compareTo(a['price'])); // Descending (High to Low)
    } else if (_activeSort == 'name') {
      filteredProducts.sort((a, b) => _isAscending
          ? a['name'].compareTo(b['name']) // Ascending (A-Z)
          : b['name'].compareTo(a['name'])); // Descending (Z-A)
    }

    return filteredProducts;
  }

  bool _isProductInPriceRange(String productPrice, String priceRange) {
    if (priceRange.contains('-')) {
      double price =
          double.parse(productPrice.replaceAll(RegExp(r'[^0-9.]'), ''));
      List<String> rangeParts = priceRange.replaceAll('\$', '').split(' - ');
      double minPrice = double.parse(rangeParts[0]);
      double maxPrice = double.parse(rangeParts[1]);
      return price >= minPrice && price <= maxPrice;
    }
    return true;
  }

  void _togglePriceSorting() {
    setState(() {
      _activeSort = 'price'; // Set active sort to price
      _isAscending = !_isAscending; // Toggle sorting order
      _fetchProducts(); // Fetch products again to apply the new sorting
    });
  }

  void _toggleNameSorting() {
    setState(() {
      _activeSort = 'name'; // Set active sort to name
      _isAscending = !_isAscending; // Toggle sorting order
      _fetchProducts(); // Fetch products again to apply the new sorting
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredProducts = _filterProducts();

    return Scaffold(
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
                MaterialPageRoute(builder: (context) => const HomepageScreen()),
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
                    if (widget.priceRange.isNotEmpty)
                      GestureDetector(
                        onTap: _togglePriceSorting,
                        child: _buildFilterItem(
                          'Price Range: ${widget.priceRange} ${_activeSort == 'price' ? (_isAscending ? "↑" : "↓") : ""}',
                        ),
                      ),
                    if (widget.productName.isNotEmpty)
                      GestureDetector(
                        onTap: _toggleNameSorting,
                        child: _buildFilterItem(
                          'Product Name: ${widget.productName} ${_activeSort == 'name' ? (_isAscending ? "↑" : "↓") : ""}',
                        ),
                      ),
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
                      price:
                          product['price'].toString(), // Ensure it's a string
                      rating: product['rating'],
                      imagePath: product['image'],
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
