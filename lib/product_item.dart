// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          // replace with product picture
          width: 68,
          height: 68,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          // Ensure the content has a defined width
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Nama Produk',
                    style: GoogleFonts.urbanist(
                      textStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Spacer(),
                  Text(
                    'x1',
                    style: GoogleFonts.urbanist(
                      textStyle: TextStyle(color: Colors.grey.shade700),
                    ),
                  ),
                ],
              ),
              Text(
                'Category',
                style: GoogleFonts.urbanist(
                  textStyle: TextStyle(color: Colors.grey.shade700),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Harga',
                style: GoogleFonts.urbanist(
                  textStyle: TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
