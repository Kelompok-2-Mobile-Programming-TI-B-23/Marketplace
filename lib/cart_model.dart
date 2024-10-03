class CartModel {
  final String userId;
  CartModel({
    required this.userId,
  });

  // Convert CartModel to a Map for storing in Firestore
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
    };
  }

  // Factory constructor to create CartModel from Firestore data
  factory CartModel.fromFirestore(Map<String, dynamic> data) {
    return CartModel(
      userId: data['userId'],
    );
  }
}
