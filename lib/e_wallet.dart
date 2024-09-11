import 'package:flutter/material.dart';

class EWalletScreen extends StatelessWidget {
  const EWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'E-Wallet',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold
            )
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 218, 207, 156),
      ),
    );
  }
}