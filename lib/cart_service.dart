import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marketplace/cart_item_model.dart';

class CartService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Fungsi untuk membuat ID untuk cart
  String _generateCartId(String userId) {
    return 'cart_$userId';
  }

  // Fungsi untuk memastikan bahwa user memiliki cart dan membuat cart bila user tidak memilikinya
  Future<void> ensureCartExists(String userId) async {
    final cartRef = _db.collection('carts').doc(_generateCartId(userId));
    DocumentSnapshot cartSnapshot = await cartRef.get();
    if (!cartSnapshot.exists) {
      await cartRef.set({});
    }
  }

  // Fungsi untuk update quantity dari item
  Future<void> updateCartItemQuantity(
      String userId, String productId, int newQuantity) async {
    final cartRef = _db.collection('carts').doc(_generateCartId(userId));
    final cartItemRef = cartRef.collection('items').doc(productId);

    if (newQuantity <= 0) {
      await cartItemRef.delete();
    } else {
      await cartItemRef.update({
        'quantity': newQuantity,
      });
    }
  }

  // Fungsi untuk menambahkan item ke dalam cart
  Future<void> addItemToCart(String userId, CartItemModel item) async {
    await ensureCartExists(userId); // Ensure the cart exists

    final cartRef = _db.collection('carts').doc(_generateCartId(userId));
    final cartItemRef = cartRef.collection('items').doc(item.productId);
    DocumentSnapshot docSnapshot = await cartItemRef.get();

    if (docSnapshot.exists) {
      await cartItemRef.update(
        {
          'quantity': FieldValue.increment(item.quantity),
        },
      );
    } else {
      await cartItemRef.set(item.toMap());
    }
  }

  // Fungsi untuk menghapus item dari cart
  Future<void> removeItemFromCart(String userId, String productId) async {
    await _db
        .collection('carts')
        .doc(_generateCartId(userId))
        .collection('items')
        .doc(productId)
        .delete();
  }

  // Fungsi untuk mendapatkan semua item dan datanya dari cart
  Future<List<Map<String, dynamic>>> getCartItemsWithDetails(
      String userId) async {
    await ensureCartExists(userId);

    QuerySnapshot cartSnapshot = await _db
        .collection('carts')
        .doc(_generateCartId(userId))
        .collection('items')
        .get();
    List<Map<String, dynamic>> cartItemsWithDetails = [];

    for (var doc in cartSnapshot.docs) {
      var cartItemData = doc.data() as Map<String, dynamic>;
      var cartItem = CartItemModel.fromFirestore(cartItemData);
      var productDetails = await getProductDetails(cartItem.productId);

      cartItemsWithDetails.add({
        'cartItem': cartItem,
        'name': productDetails['name'],
        'category': productDetails['category'],
        'image': productDetails['image'],
        'price': productDetails['price'],
      });
    }

    return cartItemsWithDetails;
  }

// Fungsi untuk mendapatkan semua data dari suatu product
  Future<Map<String, dynamic>> getProductDetails(String productId) async {
    DocumentSnapshot productSnapshot =
        await _db.collection('products').doc(productId).get();

    if (productSnapshot.exists) {
      return productSnapshot.data() as Map<String, dynamic>;
    } else {
      throw Exception("Product not found");
    }
  }
}
