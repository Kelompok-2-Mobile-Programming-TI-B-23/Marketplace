// cart_screen.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'cart_service.dart';
import 'cart_item_model.dart';
import 'cart_empty_screen.dart'; // Import the EmptyCartScreen

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartService _cartService = CartService();
  User? user;
  late Future<List<Map<String, dynamic>>> cartItemsFuture = Future.value([]); // Change this line

  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  void _initializeUser() {
    FirebaseAuth.instance.authStateChanges().listen((User? currentUser) {
      setState(() {
        user = currentUser;
        if (user != null) {
          // Update the cartItemsFuture when the user is authenticated
          cartItemsFuture = _cartService.getCartItemsWithDetails(user!.uid);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: cartItemsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Navigate to the custom empty cart screen if the cart is empty
            Future.delayed(Duration.zero, () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const CartEmptyScreen()),
              );
            });
            return const SizedBox(); // Return an empty widget
          }

          final cartItems = snapshot.data!;

          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final item = cartItems[index];
              return ListTile(
                title: Text(item['name']), // Access name from the map
                subtitle: Text('${item['cartItem'].quantity} x ${item['price']}'), // Access quantity and price
                trailing: Text('Total: ${item['cartItem'].quantity * item['price']}'), // Calculate total
                onLongPress: () =>
                    _cartService.removeItemFromCart(user!.uid, item['cartItem'].productId), // Access productId from the cart item
              );
            },
          );
        },
      ),
    );
  }
}
