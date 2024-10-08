import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marketplace/payment_screen.dart';
import 'package:marketplace/cart_service.dart';
import 'package:intl/intl.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final CartService _cartService = CartService();
  Future<List<Map<String, dynamic>>>? _cartItemsFuture;

  String _userAddress = 'Fetching address...';
  double _userBalance = 0.0;

  double _subtotal = 0.0;
  final double _deliveryFee = 10000.0;

  @override
  void initState() {
    super.initState();
    _cartItemsFuture = _fetchCartItemsWithDetails();
    _fetchUserDetails();
  }

  // Fungsi untuk mengambil data alamat dan saldo user
  Future<void> _fetchUserDetails() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      setState(() {
        _userAddress = userData['address'] ?? 'No address available';
        _userBalance = userData['balance']?.toDouble() ?? 0.0;
      });
    }
  }

  // Fungsi untuk mengambil data cart dan menghitung subtotal
  Future<List<Map<String, dynamic>>> _fetchCartItemsWithDetails() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("User is not logged in");
    }
    var cartItems = await _cartService.getCartItemsWithDetails(user.uid);
    double calculatedSubtotal = cartItems.fold<double>(
      0.0,
      (sum, item) => sum + (item['cartItem'].quantity * item['price']),
    );

    setState(() {
      _subtotal = calculatedSubtotal;
    });

    return cartItems;
  }

  // Fungsi untuk mengurangi saldo user
  Future<void> _deductBalance(double amount) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
        'balance': FieldValue.increment(-amount),
      });
      setState(() {
        _userBalance -= amount;
      });
    }
  }

  // Fungsi untuk menghapus item -item dari cart (digunakan untuk item yg dibeli)
  Future<void> _removeItemsFromCart() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      List<Map<String, dynamic>> cartItems =
          await _cartService.getCartItemsWithDetails(user.uid);

      // Loop through the cart items and remove each one
      for (var item in cartItems) {
        String? productId = item['cartItem']
            .productId; // Assuming you have productId in your cart item data
        if (productId != null) {
          await _cartService.removeItemFromCart(user.uid, productId);
        }
      }
    }
  }

  // Fungsi untuk melakukan formatting pada saldo dan harga
  String formatCurrency(double value) {
    final NumberFormat formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return formatter.format(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 248, 240),
      appBar: AppBar(
        title: const Text('Checkout',
            style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 248, 240),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _cartItemsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<Map<String, dynamic>> cartItems = snapshot.data!;

            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Shopping Address',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.location_on),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                _userAddress,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 152, 150, 150)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Payment Method',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.wallet),
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'E-wallet',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 152, 150, 150)),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                formatCurrency(_userBalance),
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 152, 150, 150)),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: const Text(
                          'Order List',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )),
                    ...cartItems.map((item) {
                      return _listProduk(
                          name: item['name'],
                          price: formatCurrency(item['price'] is int
                              ? (item['price'] as int).toDouble()
                              : item['price']),
                          category: item['category'],
                          image: item['image']);
                    }).toList(),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text('No items in the cart.'));
          }
        },
      ),
      bottomSheet: Container(
        height: 200,
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
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Sub-Total',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  formatCurrency(_subtotal),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Delivery Fee',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  formatCurrency(_deliveryFee),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
            const Divider(height: 20, thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Cost',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  formatCurrency(_subtotal + _deliveryFee),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                backgroundColor: const Color.fromARGB(255, 146, 20, 12),
              ),
              onPressed: () async {
                double totalCost = _subtotal + _deliveryFee;

                // Mengecek apakah saldo user cukup untuk membeli item item
                if (_userBalance < totalCost) {
                  // Show an alert dialog if balance is insufficient
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Insufficient Balance'),
                        content: const Text(
                            'Your balance is not enough to complete this transaction.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  await _deductBalance(totalCost);
                  await _removeItemsFromCart();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const PaymentScreen(),
                    ),
                  );
                }
              },
              child: const Text(
                'Confirm Payment',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _listProduk(
    {required String name,
    required String price,
    required String category,
    required String image}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              image,
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  category,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 152, 150, 150)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    price,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      const Divider(height: 25, thickness: 1),
    ],
  );
}
