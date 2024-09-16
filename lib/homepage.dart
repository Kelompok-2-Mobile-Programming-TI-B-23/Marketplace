import 'package:flutter/material.dart';
import 'package:marketplace/widgets/bottomNavigator.dart'; // Import BottomNavigator
import 'home_screen.dart'; // Import HomeScreen
import 'store_screen.dart'; // Import StoreScreen
import 'cart_screen.dart'; // Import CartScreen
import 'profile_screen.dart'; // Import ProfileScreen

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
        backgroundColor: const Color.fromARGB(255, 255, 248, 240),
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
