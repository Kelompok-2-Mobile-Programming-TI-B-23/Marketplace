import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CartItem extends StatelessWidget {
  final String productId;
  final String category;
  final String image;
  final String name;
  final int price;
  final int quantity;
  final bool isChecked;
  final Function(bool?) onCheckboxChanged;
  final Function onDelete;
  final Function onRemove;
  final Function onAdd;

  const CartItem({
    Key? key,
    required this.productId,
    required this.category,
    required this.image,
    required this.name,
    required this.price,
    required this.quantity,
    required this.isChecked,
    required this.onCheckboxChanged,
    required this.onDelete,
    required this.onRemove,
    required this.onAdd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Format harga menjadi Rp
    final formattedPrice = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(price);

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Checkbox(
              value: isChecked,
              onChanged: onCheckboxChanged,
              activeColor: const Color.fromARGB(255, 146, 20, 12),
            ),
            Container(
              padding: const EdgeInsets.all(0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  image,
                  height: 90,
                  width: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontSize: 18)),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                  child: Text(
                    category,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 152, 150, 150),
                    ),
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => onDelete(),
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
                      onTap: () => onRemove(),
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
                    Text(
                      '$quantity',
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Color.fromARGB(255, 146, 20, 12),
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () => onAdd(),
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
                formattedPrice,
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
  }
}
