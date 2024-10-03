import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class EWalletScreen extends StatefulWidget {
  const EWalletScreen({super.key});

  @override
  _EWalletScreenState createState() => _EWalletScreenState();
}

class _EWalletScreenState extends State<EWalletScreen> {
  double _balance = 0.0;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _loadBalance();
  }

  Future<void> _loadBalance() async {
    final user = _auth.currentUser;
    if (user == null) return;

    final snapshot = await _firestore.collection('users').doc(user.uid).get();
    final balance = snapshot.data()?['balance'] as double? ?? 0.0;
    setState(() => _balance = balance);
  }

  Future<void> _updateBalance(double newAmount) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .update({'balance': newAmount});
      _loadBalance(); // Refresh the balance
    }
  }

  String formatCurrency(double value) {
    final NumberFormat formatter =
        NumberFormat('#,##0', 'id_ID'); // Format for Indonesian locale
    return formatter.format(value);
  }

  void _showAlertDialog(BuildContext context) {
    TextEditingController amountController = TextEditingController();
    String formattedValue = '';

    amountController.addListener(() {
      final String enteredValue = amountController.text.replaceAll('.', '');
      double? value = double.tryParse(enteredValue);
      if (value != null) {
        formattedValue = formatCurrency(value);
        amountController.value = TextEditingValue(
          text: formattedValue,
          selection: TextSelection.collapsed(offset: formattedValue.length),
        );
      }
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          buttonPadding: const EdgeInsets.all(50),
          contentPadding: const EdgeInsets.fromLTRB(30, 10, 30, 30),
          title: const Text(
            'Enter Amount:',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          content: TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 3),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1.0),
              ),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                backgroundColor: const Color.fromARGB(255, 146, 20, 12),
              ),
              onPressed: () async {
                double newAmount = double.tryParse(
                        amountController.text.replaceAll('.', '')) ??
                    0.0;
                if (newAmount < 0) {
                  // Show an error message to the user
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: const Text('Top up cannot be less than 0.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else {
                  // Update the balance if the new balance is valid
                  await _updateBalance(_balance + newAmount);
                  Navigator.pop(context);
                }
              },
              child: const Text(
                'Enter',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 248, 240),
      appBar: AppBar(
        title: const Text('E-Wallet',
            style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 248, 240),
      ),
      body: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Column(children: [
          const SizedBox(height: 20),
          SvgPicture.asset('assets/icons/ion_wallet.svg'),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
            child: Column(
              children: [
                const Text(
                  'Your Balance :',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Text(
                  'Rp ${formatCurrency(_balance)}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80, vertical: 10),
                        backgroundColor:
                            const Color.fromARGB(255, 146, 20, 12)),
                    onPressed: () {
                      _showAlertDialog(context);
                    },
                    child: const Text(
                      'Top Up',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ))
              ],
            ),
          ),
        ])
      ]),
    );
  }
}
