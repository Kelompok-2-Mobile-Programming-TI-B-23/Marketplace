import 'package:flutter/material.dart';

class SearchProductCard extends StatelessWidget {
  final String productName;
  final String price;

  const SearchProductCard({
    Key? key,
    required this.productName,
    required this.price,
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
                  height: 5), // Sedikit jarak antara nama produk dan harga
              Text(
                price,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
