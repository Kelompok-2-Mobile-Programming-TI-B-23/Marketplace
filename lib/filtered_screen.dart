import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marketplace/homepage.dart';
import 'package:marketplace/product_detail.dart';
import 'widgets/product_card.dart';
import 'package:intl/intl.dart'; // Import NumberFormat for price formatting

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
  String? _activeSort; // Track the active sorting criterion ('price' or 'name')
  bool _isAscending = true; // Track sorting order (true for ascending)
  List<Map<String, dynamic>> products = [];
  String? selectedCategory; // Track the selected category

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  // Fetch products based on the selected category
  Future<void> _fetchProducts() async {
    try {
      Query query = FirebaseFirestore.instance.collection('products');

      // Filter by selected category if specified
      if (selectedCategory != null && selectedCategory!.isNotEmpty) {
        query = query.where('category', isEqualTo: selectedCategory);
      }

      // Fetch the products
      final querySnapshot = await query.get();

      if (querySnapshot.docs.isEmpty) {
        // If no products are found, handle it
        setState(() {
          products = [];
        });
        return;
      }

      // Parse the query results and handle missing fields
      setState(() {
        products = querySnapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return {
            'id': doc.id, // Ensure the document ID is included
            'name': data['name'] ?? 'Unknown',
            'price': (data['price'] is String)
                ? double.tryParse(data['price']) ?? 0.0
                : (data['price'] as num?)?.toDouble() ?? 0.0,
            'rating': (data['rating'] is String)
                ? double.tryParse(data['rating']) ?? 0.0
                : (data['rating'] as num?)?.toDouble() ?? 0.0,
            'image': data['image'] ?? 'default_image.png',
            'category': data['category'] ?? 'Unknown',
          };
        }).toList();
        _sortProducts(); // Sort products after fetching
      });
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  // Sort products based on the active sorting criteria
  void _sortProducts() {
    if (_activeSort == 'price') {
      // Sort by price
      products.sort((a, b) {
        if (_isAscending) {
          return a['price'].compareTo(b['price']);
        } else {
          return b['price'].compareTo(a['price']);
        }
      });
    } else if (_activeSort == 'name') {
      // Sort by name
      products.sort((a, b) {
        if (_isAscending) {
          return a['name'].toLowerCase().compareTo(b['name'].toLowerCase());
        } else {
          return b['name'].toLowerCase().compareTo(a['name'].toLowerCase());
        }
      });
    }
  }

  // Toggle between ascending/descending for price sorting
  void _togglePriceSorting() {
    setState(() {
      _activeSort = 'price';
      _isAscending = !_isAscending;
      _sortProducts();
    });
  }

  // Toggle between ascending/descending for name sorting
  void _toggleNameSorting() {
    setState(() {
      _activeSort = 'name';
      _isAscending = !_isAscending;
      _sortProducts();
    });
  }

  // Method to build category buttons
  Widget _buildCategoryButton(String category) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category; // Set the selected category
        });
        _fetchProducts(); // Fetch products for the selected category
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: selectedCategory == category
              ? const Color(0xFF92140C) // Active color
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF92140C)),
        ),
        child: Text(
          category,
          style: TextStyle(
            fontSize: 16,
            color: selectedCategory == category
                ? Colors.white // Active text color
                : Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Apply price or name sorting based on the active sort criteria
    List<Map<String, dynamic>> filteredProducts = products;

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
        title: Column(
          children: const [
            SizedBox(height: 30),
            Text(
              'Product Filter Results',
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              // Category buttons row
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildCategoryButton('Clothes'),
                    _buildCategoryButton('Pants'),
                    _buildCategoryButton('Shoes'),
                    _buildCategoryButton('Accessories'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Filter items
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    if (widget.category.isNotEmpty)
                      _buildFilterItem('Category: ${widget.category}'),
                    if (widget.priceRange.isNotEmpty)
                      _buildFilterItem('Price Range: ${widget.priceRange}'),
                    if (widget.productName.isNotEmpty)
                      GestureDetector(
                        onTap: _toggleNameSorting, // Toggle sorting by name
                        child: _buildFilterItem(
                            'Product Name: ${widget.productName}'),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _togglePriceSorting,
                    child: Row(
                      children: [
                        const Text('Sort by Price'),
                        Icon(_isAscending
                            ? Icons.arrow_upward
                            : Icons.arrow_downward),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: _toggleNameSorting,
                    child: Row(
                      children: [
                        const Text('Sort by Name'),
                        Icon(_isAscending
                            ? Icons.arrow_upward
                            : Icons.arrow_downward),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: filteredProducts.isNotEmpty
                    ? GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = filteredProducts[index];
                          return GestureDetector(
                            onTap: () {
                              final productId = product['id'];
                              if (productId.isNotEmpty) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetailScreen(
                                      productId: productId,
                                    ),
                                  ),
                                );
                              } else {
                                print('Invalid product ID: $productId');
                              }
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
                      )
                    : const Center(
                        child: Text('No products found'),
                      ), // Handle no products found
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
