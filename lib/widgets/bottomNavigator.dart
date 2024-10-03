import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavigator extends StatefulWidget {
  final Function(int) onTabChange;
  final int selectedIndex; // Untuk mengatur tab yang aktif

  const BottomNavigator({
    required this.onTabChange,
    required this.selectedIndex,
    super.key,
  });

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
            backgroundColor: Colors.white,
            color: Colors.black,
            activeColor: const Color(0xFF92140C), // Warna saat tab aktif
            tabBackgroundColor: const Color(0xFFEDEAE8), // Background tab aktif
            gap: 8,
            selectedIndex: widget.selectedIndex, // Indeks tab yang aktif
            onTabChange: (index) {
              widget.onTabChange(index); // Memanggil fungsi parent
            },
            padding: const EdgeInsets.all(10),
            tabs: const [
              GButton(icon: Icons.home_outlined, text: 'Home'),
              GButton(icon: Icons.tune, text: 'Filter'),
              GButton(icon: Icons.shopping_cart_outlined, text: 'Cart'),
              GButton(icon: Icons.account_circle_outlined, text: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}
