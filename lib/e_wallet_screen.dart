import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';  // Import for formatting

class EWalletScreen extends StatefulWidget {
  const EWalletScreen({super.key});

  @override
  _EWalletScreenState createState() => _EWalletScreenState();
}

class _EWalletScreenState extends State<EWalletScreen> {
  double _balance = 0.0;
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadBalance();
  }

  // Load balance from shared preferences
  Future<void> _loadBalance() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _balance = prefs.getDouble('balance') ?? 0.0;
    });
  }

  // Save balance to shared preferences
  Future<void> _saveBalance(double newBalance) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('balance', newBalance);
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          buttonPadding: const EdgeInsets.all(50),
          contentPadding: const EdgeInsets.fromLTRB(30, 10, 30, 30),
          title: const Text(
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            'Enter Amount:'
          ),
          content: TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 3),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1.0)
              ),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                backgroundColor: const Color.fromARGB(255, 146, 20, 12),
              ),
              onPressed: () {
                double enteredAmount = double.tryParse(_amountController.text) ?? 0.0;
                _updateBalance(enteredAmount);
                Navigator.pop(context);
              },
              child: const Text(
                'Enter',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  // Update balance
  void _updateBalance(double amount) {
    setState(() {
      _balance += amount;
      _saveBalance(_balance);
    });
    _amountController.clear();
  }

  // Format balance using European style (20.000,00)
  String _formatBalance(double balance) {
    final formatter = NumberFormat.currency(
      locale: 'eu',  // Setting locale to European style
      symbol: '',     // No currency symbol, only numbers
      decimalDigits: 2,
    );
    return formatter.format(balance);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 248, 240),
      appBar: AppBar(
        title: const Text(
          'E-Wallet',
          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 248, 240),
        leading: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 248, 240),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
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
                      _formatBalance(_balance),
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                        backgroundColor: const Color.fromARGB(255, 146, 20, 12),
                      ),
                      onPressed: () {
                        _showAlertDialog(context);
                      },
                      child: const Text(
                        'Top Up',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
