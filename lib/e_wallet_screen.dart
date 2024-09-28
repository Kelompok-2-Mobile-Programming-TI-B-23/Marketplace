import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EWalletScreen extends StatelessWidget {
  const EWalletScreen({super.key});

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
              'Enter Amount:'),
          content: const TextField(
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 4, horizontal: 3),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0)))),
          actions: <Widget>[
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 10),
                    backgroundColor: const Color.fromARGB(255, 146, 20, 12)),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Enter',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                )),
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
          leading: Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 248, 240),
                borderRadius: BorderRadius.circular(10)),
            child: SvgPicture.asset(
              'assets/icons/Arrow - Left 2.svg',

              height: 20,
              width: 20,
              // color: Colors.black,
            ),
          ),
          ),
      body: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Column(children: [
          const SizedBox(
            height: 20,
          ),
          SvgPicture.asset('assets/icons/ion_wallet.svg'),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
            child: Column(
              children: [
                const Text(
                  'Your Balance :',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                const Text(
                  '\$90.00',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 30,
                ),
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
