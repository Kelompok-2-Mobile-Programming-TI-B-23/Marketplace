import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketplace/widgets/screen_title.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<String> imageList = [
    "assets/images/shoes.jpg",
    "assets/images/shoes.jpg",
    "assets/images/shoes.jpg",
  ];

  List<String> productTitles = [
    "Sepatu",
    "Sepatu",
    "Sepatu",
  ];

  List<String> productCategory = [
    "Category",
    "Category",
    "Category",
  ];

  List<String> prices = [
    "\$90.00",
    "\$90.00",
    "\$90.00",
  ];

  List<bool> isChecked = [true, false, true];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 248, 240),
      // appBar: AppBar(
      //   title: const Text('My Cart',
      //       style: TextStyle(
      //           color: Colors.black,
      //           fontSize: 18,
      //           fontWeight: FontWeight.bold)),
      //   centerTitle: true,
      //   backgroundColor: const Color.fromARGB(255, 255, 248, 240),
      //   leading: Container(
      //     margin: const EdgeInsets.all(10),
      //     alignment: Alignment.center,
      //     decoration: BoxDecoration(
      //         color: const Color.fromARGB(255, 255, 248, 240),
      //         borderRadius: BorderRadius.circular(10)),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Column(
            children: [
              ScreenTitle(title: "Cart"),
              const SizedBox(height: 20),
              ListView.builder(
                itemCount: imageList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Checkbox(
                            value: isChecked[index],
                            onChanged: (val) {
                              setState(
                                () {
                                  isChecked[index] = val!;
                                },
                              );
                            },
                            activeColor: const Color.fromARGB(255, 146, 20, 12),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  10), // Half of the height/width to make it circular
                              child: Image.asset(
                                imageList[index],
                                height: 90,
                                width:
                                    90, // Ensures width and height are equal for a perfect circle
                                fit: BoxFit
                                    .cover, // Ensures the image fits within the circular area
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(productTitles[index],
                                  style: const TextStyle(fontSize: 18)),
                              Container(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                                child: Text(
                                  productCategory[index],
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 152, 150, 150),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      print('Delete icon clicked!');
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(4.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey[200],
                                      ),
                                      child: const Icon(
                                        Icons.delete,
                                        size: 14.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  GestureDetector(
                                    onTap: () {
                                      print('Remove icon clicked!');
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(4.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey[200],
                                      ),
                                      child: const Icon(
                                        Icons.remove,
                                        size: 14.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Text(
                                    '1',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: Color.fromARGB(255, 146, 20, 12),
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  GestureDetector(
                                    onTap: () {
                                      print('Add icon clicked!');
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(4.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey[200],
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        size: 14.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(0, 60, 20, 0),
                            child: Text(
                              prices[index],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(
                          height: 40,
                          thickness: 1,
                        ),
                      )
                    ],
                  );
                },
              ),
              const Divider(
                height: 150,
                thickness: 0,
              )
            ],
          ),
        ),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
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
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    '\$270.00',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60, vertical: 10),
                    backgroundColor: const Color.fromARGB(255, 146, 20, 12)),
                onPressed: () {},
                child: const Text(
                  'Checkout',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
