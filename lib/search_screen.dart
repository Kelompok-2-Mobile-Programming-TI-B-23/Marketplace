import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'filter_sort_screen.dart';
import 'widgets/search_product_card.dart';

class SearchPage extends StatefulWidget {
  final String selectedSuggestion;

  const SearchPage({super.key, required this.selectedSuggestion});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<String> _suggestions = [
    'Baju Merah',
    'Baju Merah Putih',
    'Baju Hijau',
    'Sepatu Nike',
    'Sepatu Adidas',
    'Celana Jeans',
    'Celana Pendek',
    'Kalung Emas'
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF8F0),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),

                      // Search bar
                      Row(
                        children: [
                          Expanded(
                            child: TypeAheadField<String>(
                              textFieldConfiguration: TextFieldConfiguration(
                                decoration: InputDecoration(
                                  hintText: "Search",
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  prefixIcon: const Icon(Icons.search,
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                              suggestionsCallback: (pattern) {
                                return _suggestions.where((item) => item
                                    .toLowerCase()
                                    .contains(pattern.toLowerCase()));
                              },
                              itemBuilder: (context, suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },
                              onSuggestionSelected: (suggestion) {
                                print('Selected: $suggestion');
                              },
                            ),
                          ),

                          // Filter Button
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                isScrollControlled: true,
                                builder: (context) => const FilterSortScreen(),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0xFF92140C),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child:
                                  const Icon(Icons.tune, color: Colors.white),
                            ),
                          ),
                        ],
                      ),

                      // List of product cards
                      const SizedBox(height: 20),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return const SearchProductCard(
                            productName: 'Baju',
                            price: 'Harga',
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
