import 'package:flutter/material.dart';
import 'filter_sort_screen.dart';
import 'widgets/search_product_card.dart';
import 'home_screen.dart';

class SearchPage extends StatelessWidget {
  final String selectedSuggestion;

  const SearchPage({super.key, required this.selectedSuggestion});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF8F0),
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: const Color(0xFFFFF8F0),
          leading: Padding(
            padding: const EdgeInsets.only(top: 30, left: 20),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ),
          title: Column(
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
        body: Padding(
          padding: const EdgeInsets.only(left: 30, top: 10),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  // List of product cards
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return const SearchProductCard(
                        productName: 'Baju',
                        price: 'Harga',
                        rating: 0.00,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
