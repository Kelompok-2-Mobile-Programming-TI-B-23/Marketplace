import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class CategorySelector extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const CategorySelector({
    Key? key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  }) : super(key: key);

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
                  // Container bulat untuk icon
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: selectedCategory == category
                          ? const Color.fromARGB(255, 146, 20, 12)
                          : Colors.grey[300],
                    ),
                    child: Icon(
                      category == 'T-Shirt'
                          ? MingCute.t_shirt_line
                          : category == 'Pants'
                              ? MingCute.shorts_line
                              : category == 'Shoes'
                                  ? MingCute.shoe_line
                                  : category == 'Accessory'
                                      ? MingCute.watch_2_line
                                      : Icons.grid_view,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    category,
                    style: TextStyle(
                      color: selectedCategory == category
                          ? const Color.fromARGB(255, 30, 30, 36)
                          : Colors.grey,
                    ),
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
