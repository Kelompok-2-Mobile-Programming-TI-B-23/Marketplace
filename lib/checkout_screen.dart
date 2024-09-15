import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            )),
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
              SizedBox(
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
                          Padding(padding: EdgeInsets.all(8), child: Text(
                            'E-wallet',
                            style: TextStyle(
                                color: Color.fromARGB(255, 152, 150, 150)),
                          ) ,),
                          
                        ],
                      ),
                      Padding(padding: EdgeInsets.all(8), child: Text(
                        '0.00',
                        style: TextStyle(
                            color: Color.fromARGB(255, 152, 150, 150)),
                      ),)
                      
                    ],
                  )
                ],
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: Text(
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
              Divider(
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
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 10),
                      backgroundColor: const Color.fromARGB(255, 146, 20, 12)),
                  onPressed: () {},
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
            child: Image(
                width: 90,
                height: 90,
                image: AssetImage(
                  "assets/images/shoes.jpg",
                )),
          ),
          Padding(
            //ini buat produknya
            padding: EdgeInsets.symmetric(horizontal: 20), //ini buat produknya
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(namaProduk, style: TextStyle(fontSize: 20),),
                Text(
                  "Category",
                  style: TextStyle(color: Color.fromARGB(255, 152, 150, 150)),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    harga,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      Divider(
        height: 25,
        thickness: 1,
      ),
    ],
  ); //ini buat produknya
}
