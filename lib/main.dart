import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'product_detail.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductDetailScreen(productId: 'product1'),
    );
  }
}
