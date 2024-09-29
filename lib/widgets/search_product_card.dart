import 'package:flutter/material.dart';

class SearchProductCard extends StatelessWidget {
  final String productName;
  final String price;
  final double rating;

  const SearchProductCard({
    Key? key,
    required this.productName,
    required this.price,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Menyelaraskan teks ke atas
        children: [
          // Placeholder for product image
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Center(
              child: Icon(Icons.image, color: Colors.grey),
            ),
          ),
          const SizedBox(width: 10),

          // Product name and price
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                  height: 5), // Space beetween product's name and price
              Text(
                price,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20), // Space between price and rating
              Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow, size: 20),
                  const SizedBox(width: 5),
                  Text(
                    rating.toString(), // Display the rating
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
