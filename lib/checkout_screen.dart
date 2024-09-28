import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'payment_screen.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Shopping Address',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          'Home',
                          style: TextStyle(
                              color: Color.fromARGB(255, 152, 150, 150)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Payment Method',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.wallet),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'E-wallet',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 152, 150, 150)),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          '0.00',
                          style: TextStyle(
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
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )),
              _listProduk(namaProduk: 'Sepatu KW', harga: "Rp. 5000"),
              _listProduk(namaProduk: 'Sepatu Ori', harga: "Rp. 10.000")
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: 200,
        padding: const EdgeInsets.all(16.0),

        // shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 248, 240),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        child: Container(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sub-Total',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '0.00',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Delivery Fee',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '0.00',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
              const Divider(
                height: 20,
                thickness: 1,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Cost',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '0.00',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 10),
                      backgroundColor: const Color.fromARGB(255, 146, 20, 12)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PaymentScreen()),
                    );
                  },
                  child: const Text(
                    'Confirm Payment',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

Widget _listProduk({required String namaProduk, required String harga}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: const Image(
                width: 90,
                height: 90,
                image: AssetImage(
                  "assets/images/shoes.jpg",
                )),
          ),
          Padding(
            //ini buat produknya
            padding:
                const EdgeInsets.symmetric(horizontal: 20), //ini buat produknya
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  namaProduk,
                  style: const TextStyle(fontSize: 20),
                ),
                const Text(
                  "Category",
                  style: TextStyle(color: Color.fromARGB(255, 152, 150, 150)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    harga,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      const Divider(
        height: 25,
        thickness: 1,
      ),
    ],
  ); //ini buat produknya
}
