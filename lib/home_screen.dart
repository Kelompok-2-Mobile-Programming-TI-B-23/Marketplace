import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marketplace/e_wallet_screen.dart';
import 'package:marketplace/widgets/clothify_logo.dart';
import 'package:marketplace/widgets/product_grid.dart'; // Import ProductGrid
import 'search_screen.dart';
import 'package:marketplace/product_detail.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:marketplace/widgets/product_card.dart';

// Local images for carousel
final List<String> imagePaths = [
  'assets/images/sale1.png',
  'assets/images/sale2.png',
  'assets/images/sale3.png',
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

final PageController _pageController = PageController(initialPage: 0);
Timer? _timer;

class _HomeScreenState extends State<HomeScreen> {
  late List<Widget> _pages;
  int _activePage = 0;
  List<Map<String, dynamic>> selectedProducts =
      []; // List to hold selected products

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.page == imagePaths.length - 1) {
        _pageController.animateToPage(0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
      } else {
        _pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _pages = List.generate(
      imagePaths.length,
      (index) => ImagePlaceholder(
        imagePath: imagePaths[index],
      ),
    );
    startTimer();
    fetchSelectedProducts(); // Fetch selected products from Firestore
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  Future<void> fetchSelectedProducts() async {
    try {
      final categories = ['Clothes', 'Pants', 'Accessories', 'Shoes'];
      for (String category in categories) {
        final QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('products')
            .where('category', isEqualTo: category)
            .limit(1) // Get only one item per category
            .get();

        if (snapshot.docs.isNotEmpty) {
          var data = snapshot.docs.first.data() as Map<String, dynamic>;
          selectedProducts.add({
            'id': snapshot.docs.first.id,
            'name': data['name'] ?? 'No Name',
            'price': 'Rp ${data['price']?.toString() ?? '0'}',
            'rating': (data['rating'] is double)
                ? data['rating'].toString()
                : (data['rating'] is int
                    ? (data['rating'] as int).toDouble().toString()
                    : '0.0'),
            'image': data['image'] ?? 'https://via.placeholder.com/150',
          });
        }
      }

      setState(() {});
    } catch (e) {
      print("Error fetching selected products: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 248, 240),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const ClothifyLogo(),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    // Search Bar
                    Row(
                      children: [
                        Expanded(
                          child: TypeAheadField<String>(
                            textFieldConfiguration: TextFieldConfiguration(
                              decoration: InputDecoration(
                                hintText: "Search",
                                prefixIcon: const Icon(Icons.search,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 146, 20, 12),
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                            suggestionsCallback: (pattern) async {
                              if (pattern.isEmpty) {
                                return [];
                              }

                              final QuerySnapshot snapshot =
                                  await FirebaseFirestore
                                      .instance
                                      .collection('products')
                                      .where('name',
                                          isGreaterThanOrEqualTo: pattern)
                                      .where('name',
                                          isLessThanOrEqualTo:
                                              pattern + '\uf8ff')
                                      .get();

                              List<String> matchingProducts = snapshot.docs
                                  .map((doc) => doc['name'] as String)
                                  .toList();

                              return matchingProducts;
                            },
                            itemBuilder: (context, suggestion) {
                              return ListTile(
                                title: Text(suggestion),
                              );
                            },
                            onSuggestionSelected: (suggestion) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SearchPage(
                                      selectedSuggestion: suggestion),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const EWalletScreen()),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(0xFF92140C),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child:
                                const Icon(Icons.wallet, color: Colors.white),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Carousel Section
                    SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 4,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: imagePaths.length,
                        onPageChanged: (value) {
                          setState(() {
                            _activePage = value;
                          });
                        },
                        itemBuilder: (context, index) {
                          return _pages[index];
                        },
                      ),
                    ),

                    // Carousel Indicators
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List<Widget>.generate(
                        _pages.length,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: InkWell(
                            onTap: () {
                              _pageController.animateToPage(index,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn);
                            },
                            child: CircleAvatar(
                              radius: 4,
                              backgroundColor: _activePage == index
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Recommendations Section
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Recommendations 🔥",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),

                    // Product Grid
                    const ProductGrid(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImagePlaceholder extends StatelessWidget {
  final String? imagePath;
  const ImagePlaceholder({super.key, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Image.asset(imagePath!, fit: BoxFit.cover);
  }
}
