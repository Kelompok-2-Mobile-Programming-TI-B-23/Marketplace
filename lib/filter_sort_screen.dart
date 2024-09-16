import 'package:flutter/material.dart';

class FilterSortScreen extends StatefulWidget {
  const FilterSortScreen({super.key});

  @override
  _FilterSortScreenState createState() => _FilterSortScreenState();
}

class _FilterSortScreenState extends State<FilterSortScreen> {
  // State variables to track selected options
  String selectedCategory = '';
  String selectedGender = '';
  String selectedPriceRange = '';
  String selectedProductName = '';

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.7,
      child: DraggableScrollableSheet(
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                Container(
                  color: const Color(0xFF92140C),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'Sort & Filter',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Divider(
                        color: Colors.white,
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                      ),
                      const SizedBox(height: 20),
                      _buildFilterSection(
                        'Category',
                        ['Shirt', 'Pants', 'Shoes', 'Accessories'],
                        selectedCategory,
                        (value) {
                          setState(() {
                            selectedCategory = value;
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      _buildFilterSection(
                        'Gender',
                        ['All', 'Men', 'Women'],
                        selectedGender,
                        (value) {
                          setState(() {
                            selectedGender = value;
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      _buildFilterSection(
                        'Price Range',
                        ['Low to High', 'High to Low'],
                        selectedPriceRange,
                        (value) {
                          setState(() {
                            selectedPriceRange = value;
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      _buildFilterSection(
                        'Product\'s Name',
                        ['A - Z', 'Z - A'],
                        selectedProductName,
                        (value) {
                          setState(() {
                            selectedProductName = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Dashed line and Apply button at the bottom
                Container(
                  color: const Color(0xFF92140C),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 1,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final boxWidth = constraints.constrainWidth();
                            const dashWidth = 10.0;
                            const dashSpace = 5.0;
                            final dashCount =
                                (boxWidth / (dashWidth + dashSpace)).floor();
                            return Flex(
                              children: List.generate(dashCount, (_) {
                                return const SizedBox(
                                  width: dashWidth,
                                  height: 1,
                                  child: DecoratedBox(
                                    decoration:
                                        BoxDecoration(color: Colors.white),
                                  ),
                                );
                              }),
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              direction: Axis.horizontal,
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 25),
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFF5E1),
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Apply'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // A method to build a filter section with buttons
  Widget _buildFilterSection(String title, List<String> options,
      String selectedOption, Function(String) onSelect) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          children: options.map((option) {
            final isSelected = selectedOption == option;
            return GestureDetector(
              onTap: () {
                onSelect(option);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.black : Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  option,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
