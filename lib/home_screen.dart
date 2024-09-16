import 'dart:async';
import 'package:flutter/material.dart';
import 'package:marketplace/widgets/clothify_logo.dart';
import 'package:marketplace/widgets/product_card.dart'; // Import ProductCard widget

// Local images
final List<String> imagePaths = [
  'assets/images/tester1.png',
  'assets/images/tester2.png',
  'assets/images/tester3.png',
];

late List<Widget> _pages; // Untuk menampung gambar

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

// Mengontrol perpindahan halaman pada PageView
final PageController _pageController = PageController(initialPage: 0);

// Timer auto slide carousel di homepage
Timer? _timer;

class _HomeScreenState extends State<HomeScreen> {
  late List<Widget> _pages; // Widget gambar

  int _activePage = 0; // Gambar pertama

  // Dummy Hot Item
  final List<Map<String, dynamic>> hotItems = [
    {
      'name': 'Hot Item 1',
      'price': 'Rp 100.000',
      'rating': 4.5,
    },
    {
      'name': 'Hot Item 2',
      'price': 'Rp 150.000',
      'rating': 4.0,
    },
    {
      'name': 'Hot Item 3',
      'price': 'Rp 200.000',
      'rating': 3.5,
    },
    {
      'name': 'Hot Item 4',
      'price': 'Rp 250.000',
      'rating': 5.0,
    },
  ];

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_pageController.page == imagePaths.length - 1) {
        // Check apakah ini last image, jika iya pindah ke halaman pertama
        _pageController.animateToPage(0,
            duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      } else {
        // Jika bukan, pindah ke halaman berikutnya
        _pageController.nextPage(
            duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // Mengenerate widget ImagePlaceholder untuk tiap gambar
    _pages = List.generate(
      imagePaths.length,
      (index) => ImagePlaceholder(
        imagePath: imagePaths[index],
      ),
    );
    startTimer(); // Mulai automatic slide
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel(); // Timer stop ketika widget dibuang
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ClothifyLogo(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      // Search bar
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search",
                            prefixIcon: const Icon(Icons.search,
                                color: Color.fromARGB(255, 0, 0, 0)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
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
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),

                      // Filter Button
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF92140C),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Icon(Icons.tune, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  // Page View untuk gambar diskon / produk yang lagi hots
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 4,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: imagePaths.length,
                      onPageChanged: (value) {
                        setState(() {
                          _activePage = value; // Update halaman yang lagi aktif
                        });
                      },
                      itemBuilder: (context, index) {
                        return _pages[
                            index]; // Pakai pages yang sudah digenerate
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  // Indikator halaman slide page view
                  Container(
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List<Widget>.generate(
                          _pages.length,
                          (index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                child: InkWell(
                                  onTap: () {
                                    _pageController.animateToPage(index,
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeIn);
                                  },
                                  child: CircleAvatar(
                                    radius: 4,
                                    backgroundColor: _activePage == index
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                ),
                              )),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  // Category Text
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Hot Items",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(height: 8.0),

                  // Hot Items Grid
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 3 / 4,
                    ),
                    itemCount: hotItems.length,
                    itemBuilder: (context, index) {
                      final item = hotItems[index];
                      return ProductCard(
                        name: item['name'],
                        price: item['price'],
                        rating: item['rating'],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Placeholder untuk gambar dalam slider (carousel)
class ImagePlaceholder extends StatelessWidget {
  final String? imagePath;
  const ImagePlaceholder({super.key, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Image.asset(imagePath!, fit: BoxFit.cover);
  }
}
