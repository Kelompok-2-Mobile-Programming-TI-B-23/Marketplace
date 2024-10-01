class CartItemModel {
  final String productId;
  final int quantity;
  final String name;
  final String category;
  final double price;
  final String image;

  CartItemModel({
    required this.productId,
    required this.quantity,
    required this.name,
    required this.category,
    required this.price,
    required this.image,
  });

  // Convert CartItemModel to a Map for storing in Firestore
  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'quantity': quantity,
      'name': name,
      'category': category,
      'price': price,
      'image': image,
    };
  }

  // Factory constructor to create CartItemModel from Firestore data
  factory CartItemModel.fromFirestore(Map<String, dynamic> data) {
    return CartItemModel(
      productId: data['productId'],
      quantity: data['quantity'],
      name: data['name'],
      category: data['category'],
      price: data['price'],
      image: data['image'],
    );
  }
}
