import 'package:flutter/material.dart';

class ClothifyLogo extends StatelessWidget {
  final double width;

  // Opsi misal mau logonya dibesarin
  const ClothifyLogo({super.key, this.width = 150});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/images/clothify_red_no_back.png',
        width: width,
      ),
    );
  }
}
