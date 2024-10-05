import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class CategorySelector extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const CategorySelector({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          return GestureDetector(
            onTap: () {
              onCategorySelected(category);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    padding: selectedCategory == category
                        ? const EdgeInsets.all(20)
                        : const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: selectedCategory == category
                          ? const Color.fromARGB(255, 146, 20, 12)
                          : Colors.grey[300],
                    ),
                    child: Icon(
                      category == 'Clothes'
                          ? MingCute.t_shirt_line
                          : category == 'Pants'
                              ? MingCute.shorts_line
                              : category == 'Shoes'
                                  ? MingCute.shoe_line
                                  : category == 'Accessories'
                                      ? MingCute.watch_2_line
                                      : Icons.grid_view,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(height: 5),
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: TextStyle(
                      color: selectedCategory == category
                          ? const Color.fromARGB(255, 30, 30, 36)
                          : Colors.grey,
                      fontWeight: selectedCategory == category
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                    child: Text(category),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
