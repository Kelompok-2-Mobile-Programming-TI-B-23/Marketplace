import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 248, 240),
      appBar: AppBar(
        title: const Text('My Cart',
            style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 248, 240),
        leading: Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 248, 240),
                borderRadius: BorderRadius.circular(10)),
            child: SvgPicture.asset(
              'assets/icons/Arrow - Left 2.svg',
              height: 20,
              width: 20,
            )),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Container(
            height: 140,
            // color: Colors.amber[600],
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 1.0,
                        color: Color.fromARGB(255, 152, 150, 150)))),
            child: const Center(child: Text('Entry A')),
          ),
          Container(
            height: 140,
            // color: Colors.amber[600],
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 1.0,
                        color: Color.fromARGB(255, 152, 150, 150)))),
            child: const Center(child: Text('Entry A')),
          ),
          Container(
            height: 140,
            // color: Colors.amber[600],
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 1.0,
                        color: Color.fromARGB(255, 152, 150, 150)))),
            child: const Center(child: Text('Entry A')),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
            BottomNavigationBarItem(label: 'Store', icon: Icon(Icons.store)),
            BottomNavigationBarItem(label: 'Cart', icon: Icon(Icons.shop)),
            BottomNavigationBarItem(label: 'Profile', icon: Icon(Icons.person)),
          ]),
    );
  }
}
