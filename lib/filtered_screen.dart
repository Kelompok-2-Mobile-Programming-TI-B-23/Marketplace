import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/clothify.png',
                      height: 40,
                      width: 150,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.black),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Expanded(
                          child: Center(
                            child: const Text(
                              'Filtered Results',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        // Empty widget to keep alignment correct
                        SizedBox(width: 48), // Adjust width as needed
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
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
