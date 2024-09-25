import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartEmptyScreen extends StatelessWidget {
  const CartEmptyScreen({super.key});

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
        ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/icons/Frame.svg'),
              const Text(
                'Your Cart Is Empty',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ],
      ),
      
    );
  }
}
