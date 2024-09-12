import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: const [
            SizedBox(height: 50),
          ],
        ),
      ),
      bottomNavigationBar: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
            child: GNav(
              backgroundColor: Colors.white,
              color: Colors.black,
              activeColor: const Color(0xFF92140C),
              tabBackgroundColor: const Color(0xFFEDEAE8),
              gap: 8,
              onTabChange: (index) {
                print(index);
              },
              padding: EdgeInsets.all(10),
              tabs: const [
                GButton(icon: Icons.home_outlined, text: 'Home'),
                GButton(icon: Icons.store_outlined, text: 'Store'),
                GButton(icon: Icons.shopping_cart_outlined, text: 'Cart'),
                GButton(icon: Icons.account_circle_outlined, text: 'Profile'),
              ],
            ),
          )),
    ));
  }
}
