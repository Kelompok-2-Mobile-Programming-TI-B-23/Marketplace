import 'package:flutter/material.dart';
import 'filter_sort_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _openIconButtonPressed() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => FilterSortScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: _openIconButtonPressed,
            icon: const Icon(Icons.tune),
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Home screen',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
