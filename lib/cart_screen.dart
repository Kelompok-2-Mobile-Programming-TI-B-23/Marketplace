import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:marketplace/cart_service.dart';
import 'package:marketplace/checkout_screen.dart';
import 'package:marketplace/widgets/cart_items.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketplace/widgets/screen_title.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _isLoading = false;
  final CartService _cartService = CartService();
  User? user = FirebaseAuth.instance.currentUser;
  late Future<List<Map<String, dynamic>>> cartItemsFuture = Future.value([]);

  final NumberFormat formatCurrency =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

  @override
  void initState() {
    _initializeUser();
    _fetchCartItems();
    super.initState();
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

  // Fungsi untuk fetching
  void _fetchCartItems() {
    setState(() {
      _isLoading = true; // Start loading
      cartItemsFuture =
          _cartService.getCartItemsWithDetails(user!.uid).whenComplete(() {
        setState(() {
          _isLoading = false; // Stop loading when the data is fetched
        });
      });
    });
  }

  // Fungsi untuk menambahkan quantity
  void _increaseQuantity(String productId, int currentQuantity) async {
    await _cartService.updateCartItemQuantity(
        user!.uid, productId, currentQuantity + 1);
    _fetchCartItems();
  }

  // Fungsi untuk mengurangi quantity
  void _decreaseQuantity(String productId, int currentQuantity) async {
    if (currentQuantity > 1) {
      await _cartService.updateCartItemQuantity(
          user!.uid, productId, currentQuantity - 1);
    } else {
      await _cartService.updateCartItemQuantity(
          user!.uid, productId, 0); // Remove the item
    }
    _fetchCartItems();
  }

  // Fungsi untuk menghapus item dari cart

  void _removeItem(String productId) async {
    await _cartService.removeItemFromCart(user!.uid, productId);
    _fetchCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 248, 240),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 248, 240),
        title: const Column(
          children: [
            SizedBox(height: 60),
            ScreenTitle(title: "My Cart"),
            SizedBox(height: 50),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(
              child:
                  CircularProgressIndicator()) // Show loading indicator while fetching data
          : FutureBuilder<List<Map<String, dynamic>>>(
              future: cartItemsFuture,
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/icons/Frame.svg'),
                        const SizedBox(height: 20),
                        const Text(
                          'Your cart is empty.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                final cartItems = snapshot.data!;

                return ListView.builder(
                  padding: const EdgeInsets.only(top: 15.0),
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];

                    return CartItem(
                      productId: item['cartItem'].productId,
                      category: item['category'],
                      image: item['image'],
                      name: item['name'],
                      price: item['price'],
                      quantity: item['cartItem'].quantity,
                      onDelete: () {
                        _removeItem(item['cartItem'].productId);
                      },
                      onRemove: () => _decreaseQuantity(
                          item['cartItem'].productId,
                          item['cartItem'].quantity),
                      onAdd: () => _increaseQuantity(item['cartItem'].productId,
                          item['cartItem'].quantity),
                    );
                  },
                );
              },
            ),
      bottomSheet: FutureBuilder<List<Map<String, dynamic>>>(
        future: cartItemsFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const SizedBox(); //
          }

          final cartItems = snapshot.data!;
          final totalAmount = cartItems.fold<double>(
              0,
              (sum, item) =>
                  sum +
                  (item['cartItem'].quantity * (item['price'] as num))
                      .toDouble());

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
                    backgroundColor: const Color.fromARGB(255, 146, 20, 12),
                  ),
                  onPressed: () {
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
