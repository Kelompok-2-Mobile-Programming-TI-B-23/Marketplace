import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EWalletScreen extends StatelessWidget {
  const EWalletScreen({super.key});

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
          actions: [
            Container(
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
            )
          ]),
      body: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Column(children: [
          SizedBox(
            height: 20,
          ),
          SvgPicture.asset('assets/icons/ion_wallet.svg'),
          Container(
            padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
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
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80, vertical: 10),
                        backgroundColor: Color.fromARGB(255, 146, 20, 12)),
                    onPressed: () {},
                    child: Text(
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
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
            BottomNavigationBarItem(label: 'Store', icon: Icon(Icons.store)),
            BottomNavigationBarItem(label: 'Cart', icon: Icon(Icons.shop)),
            BottomNavigationBarItem(label: 'Profile', icon: Icon(Icons.person)),
          ]),
    );
  }
}
