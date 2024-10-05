import 'package:flutter/material.dart';

class CheckBoxWithAsset extends StatefulWidget {
  const CheckBoxWithAsset({super.key});

  @override
  State<CheckBoxWithAsset> createState() => _CheckBoxWithAssetState();
}

class _CheckBoxWithAssetState extends State<CheckBoxWithAsset> {
  bool isChecked = false; // Boolean to track the checkbox state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkbox with Asset'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Displaying image from assets folder
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Image.asset(
                'assets/icons/Rectangle 29.svg', 
                width: 100,
                height: 100,
              ),
            ),
            // Custom checkbox implementation
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Select Image:'),
                Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value ?? false;
                    });
                  },
                  activeColor: Colors.deepPurple, // Active checkbox color
                  checkColor: Colors.white, // Color of the checkmark
                ),
              ],
            ),
            // Displaying a message based on checkbox status
            Text(
              isChecked ? 'Image Selected' : 'Image Not Selected',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: CheckBoxWithAsset(),
  ));
}
