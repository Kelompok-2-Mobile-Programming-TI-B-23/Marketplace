import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'bottomNavigator.dart'; // Import BottomNavigator
import 'package:icons_plus/icons_plus.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  int _selectedIndex = 0; // Menyimpan index tab yang sedang dipilih

  final List<Widget> _screens = [
    const HomeScreen(), // Konten untuk Home
    const StoreScreen(), // Konten untuk Store
    const CartScreen(), // Konten untuk Cart
    const ProfileScreen(), // Konten untuk Profile
  ];

  // Fungsi untuk ngatur perubahan tab
  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index; // Mengubah tab yang dipilih
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context)
            .unfocus(); // Menghilangkan keyboard saat layar disentuh
      },
      child: Scaffold(
        body: _screens[
            _selectedIndex], // Menampilkan konten sesuai tab yang dipilih
        bottomNavigationBar: BottomNavigator(
          onTabChange: _onTabChange,
          selectedIndex:
              _selectedIndex, // Mengirim selectedIndex ke BottomNavigator
        ),
      ),
    );
  }
}

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

// Timer auto slide gambar di homepage
Timer? _timer;

class _HomeScreenState extends State<HomeScreen> {
  late List<Widget> _pages; // Widget gambar

  int _activePage = 0; // Gambar pertama

  String selectedCategory = 'All'; // Default cateogry

  // Dummy data
  final List<Map<String, dynamic>> allProducts = [
    {
      'name': 'T-Shirt 1',
      'category': 'T-Shirt',
      'price': 'Rp 100.000',
      'rating': 4.5
    },
    {
      'name': 'T-Shirt 2',
      'category': 'T-Shirt',
      'price': 'Rp 150.000',
      'rating': 4.0
    },
    {
      'name': 'Pants 1',
      'category': 'Pants',
      'price': 'Rp 200.000',
      'rating': 3.5
    },
    {
      'name': 'Shoes 1',
      'category': 'Shoes',
      'price': 'Rp 300.000',
      'rating': 5.0
    },
    {
      'name': 'Accessoryyyyyyyyyyy 1',
      'category': 'Accessory',
      'price': 'Rp 50.000',
      'rating': 3.0
    },
  ];

  // Categories
  final List<String> categories = [
    'All',
    'T-Shirt',
    'Pants',
    'Shoes',
    'Accessory'
  ];

  // Ambil product berdasarkan category
  List<Map<String, dynamic>> get filteredProducts {
    if (selectedCategory == 'All') {
      return allProducts;
    } else {
      return allProducts
          .where((product) => product['category'] == selectedCategory)
          .toList();
    }
  }

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
            Center(
              child: Image.asset(
                'assets/images/clothify_red_no_back.png',
                width: 150,
              ),
            ),
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
                            hintStyle: GoogleFonts.urbanist(color: Colors.grey),
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
                      "Category",
                      style: GoogleFonts.urbanist(
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Horizontal Category Buttons
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: categories.map((category) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategory =
                                  category; // Mengubah category yang lagi dipilih
                            });
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              children: [
                                // Container bulat untuk icon
                                Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: selectedCategory == category
                                        ? Color.fromARGB(255, 146, 20, 12)
                                        : Colors.grey[
                                            300], // Warna berubah saat category dipilih
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
                                                    : Icons
                                                        .grid_view, // Ikon default
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  category,
                                  style: TextStyle(
                                    color: selectedCategory == category
                                        ? Color.fromARGB(255, 30, 30, 36)
                                        : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Product Grid
                  GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 3 / 4,
                      ),
                      itemCount: filteredProducts
                          .length, // Jumlah produk yang ditampilkan
                      itemBuilder: (context, index) {
                        // Mengambil data produk
                        final product = filteredProducts[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 3,
                          child: Column(
                            children: [
                              // Placeholder untuk gambar produk masih dummy
                              Container(
                                height: 130,
                                color: Colors.grey[200],
                                child: Center(
                                  child: Icon(
                                    Icons.image,
                                    size: 50,
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Nama Product
                                        Expanded(
                                          child: Text(
                                            product['name'],
                                            style: TextStyle(fontSize: 12),
                                            maxLines:
                                                1, // Melimit title produk agar 1 baris
                                            overflow: TextOverflow
                                                .ellipsis, // Menambahkan ... jika title produk terlalu panjang
                                          ),
                                        ),

                                        SizedBox(
                                          width: 5,
                                        ),
                                        // Rating
                                        Row(
                                          children: [
                                            Icon(Icons.star,
                                                color: Colors.yellow, size: 16),
                                            SizedBox(width: 4),
                                            Text(
                                              product['rating'].toString(),
                                              style: TextStyle(fontSize: 10),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),

                                    // Harga Produk
                                    Text(
                                      product['price'],
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 30, 30, 36),
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                  SizedBox(height: 8.0),
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

// Widget untuk layar Toko
class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Store Screen'),
    );
  }
}

// Widget untuk layar Keranjang
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Cart Screen'),
    );
  }
}

// Widget untuk layar Profil
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Profile Screen'),
    );
  }
}
