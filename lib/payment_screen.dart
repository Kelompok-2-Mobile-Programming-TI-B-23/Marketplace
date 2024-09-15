import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 248, 240),
      appBar: AppBar(
        title: const Text('Payment',
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
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/icons/gg_check-o.svg'),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                child: const Column(
                  children: [
                    Text(
                      'Payment Successful',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Your order has been processed',
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(136, 135, 134, 0.937)),
                    ),
                    SizedBox(height: 50,),
                    
                  ],
                ),
              ),
              
            ],
          ),
        ],
      ),
      bottomSheet: Container(
        height: 150,
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
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80, vertical: 10),
                        backgroundColor:
                            const Color.fromARGB(255, 146, 20, 12)),
                    onPressed: () {},
                    child: const Text(
                      'Back to Home',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    )),
          ]
        ),
      ),
    );
  }
}

class BackHomeButton extends StatelessWidget {
  const BackHomeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: (){}, child: 
    const Text('Back to Home'));
  }
}
