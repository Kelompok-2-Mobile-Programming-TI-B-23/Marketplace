import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart'; 
import 'cart_service.dart';
import 'cart_item_model.dart';
import 'cart_empty_screen.dart'; 
import 'checkout_screen.dart';
import 'package:marketplace/widgets/cart_items.dart'; 

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartService _cartService = CartService();
  User? user;
  late Future<List<Map<String, dynamic>>> cartItemsFuture = Future.value([]);

  final NumberFormat formatCurrency =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

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
          cartItemsFuture = _cartService.getCartItemsWithDetails(user!.uid);
        }
      });
    });
  }

  // Handle increasing the quantity of a cart item
  void _fetchCartItems() {
    setState(() {
      cartItemsFuture = _cartService.getCartItemsWithDetails(user!.uid);
    });
  }

  // Handle increasing the quantity of a cart item
  void _increaseQuantity(String productId, int currentQuantity) async {
    await _cartService.updateCartItemQuantity(user!.uid, productId, currentQuantity + 1);
    _fetchCartItems(); // Refresh the cart items after updating quantity
  }

  // Handle decreasing the quantity of a cart item
  void _decreaseQuantity(String productId, int currentQuantity) async {
    if (currentQuantity > 1) {
      await _cartService.updateCartItemQuantity(user!.uid, productId, currentQuantity - 1);
    } else {
      await _cartService.updateCartItemQuantity(user!.uid, productId, 0); // Remove the item
    }
    _fetchCartItems(); // Refresh the cart items after updating quantity
  }

  void _removeItem(String productId) async {
    await _cartService.removeItemFromCart(user!.uid, productId);
    _fetchCartItems();
  }

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
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: cartItemsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Navigate to the empty cart screen if the cart is empty
            Future.delayed(Duration.zero, () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const CartEmptyScreen()),
              );
            });
            return const SizedBox(); // Return an empty widget
          }

          final cartItems = snapshot.data!;
  
          return ListView.builder(
            padding: const EdgeInsets.only(top: 15.0),
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final item = cartItems[index];
              final totalPrice = item['cartItem'].quantity * item['price'];

              return CartItem(
                productId: item['cartItem'].productId,
                category: item['category'],
                image: item['image'],
                name: item['name'],
                price: item['price'],
                quantity: item['cartItem'].quantity,

                onDelete: () {
                  _removeItem(
                item['cartItem'].productId);
                },
                onRemove: () => 
                  _decreaseQuantity(item['cartItem'].productId, item['cartItem'].quantity),
                onAdd: () =>  _increaseQuantity(item['cartItem'].productId, item['cartItem'].quantity),
              );
            },
          );
        },
      ),
      bottomSheet: FutureBuilder<List<Map<String, dynamic>>>(
        future: cartItemsFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const SizedBox(); // Return empty if no items
          }

          final cartItems = snapshot.data!;
          final totalAmount = cartItems.fold<double>(
              0,
              (sum, item) =>
                  sum + (item['cartItem'].quantity * (item['price'] as num)).toDouble());

          return Container(
            height: 150,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 248, 240),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'Grand Total',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 152, 150, 150),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        formatCurrency.format(totalAmount),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60, vertical: 10),
                    backgroundColor:
                        const Color.fromARGB(255, 146, 20, 12),
                  ),
                  onPressed: () {
                    // Navigate to checkout screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CheckoutScreen()),
                    );
                  },
                  child: const Text(
                    'Checkout',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
