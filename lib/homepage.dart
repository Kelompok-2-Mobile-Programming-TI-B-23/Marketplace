import 'package:flutter/material.dart';
import 'package:marketplace/widgets/bottomNavigator.dart'; // Import BottomNavigator
import 'home_screen.dart'; // Import HomeScreen
import 'filter_sort.dart'; // Import StoreScreen
import 'cart_screen.dart'; // Import CartScreen
import 'profile.dart'; // Import ProfileScreen
import 'cart_screen.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  int _selectedIndex = 0; // Menyimpan index tab yang sedang dipilih

  Widget _cartScreen = CartScreen(key: UniqueKey());

  final List<Widget> _screens = [
    const HomeScreen(), // Konten untuk Home
    const FilterSort(), // Konten untuk Store
     CartScreen(key: UniqueKey()), // Konten untuk Cart
    const Profile(), // Konten untuk Profile
  ];

  // Fungsi untuk ngatur perubahan tab
  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index; // Mengubah tab yang dipilih
      if(index == 2){
        _cartScreen = CartScreen(key: UniqueKey()); 
        _screens[2] = _cartScreen;
      }
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
        backgroundColor: const Color.fromARGB(255, 255, 248, 240),
        body: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
        bottomNavigationBar: BottomNavigator(
          onTabChange: _onTabChange,
          selectedIndex:
              _selectedIndex, // Mengirim selectedIndex ke BottomNavigator
        ),
      ),
    );
  }
}
