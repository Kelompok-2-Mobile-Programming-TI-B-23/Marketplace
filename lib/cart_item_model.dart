class CartItemModel {
  final String productId;
  final int quantity;
  bool isChecked; 

  CartItemModel({
    required this.productId,
    required this.quantity,
     this.isChecked = false, 
  });

  // Convert CartItemModel to a Map for storing in Firestore
  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'quantity': quantity,
      'isChecked': isChecked, 
    };
  }

  // Factory constructor to create CartItemModel from Firestore data
  factory CartItemModel.fromFirestore(Map<String, dynamic> data) {
    return CartItemModel(
      productId: data['productId'],
      quantity: data['quantity'],

    );
  }
}
