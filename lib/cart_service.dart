import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marketplace/cart_item_model.dart';

class CartService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Create a unique ID for the cart document
  String _generateCartId(String userId) {
    return 'cart_$userId'; // Generate a unique ID using the user ID
  }

  // Check if the user has a cart, if not create it
  Future<void> ensureCartExists(String userId) async {
    final cartRef = _db.collection('carts').doc(_generateCartId(userId));
    DocumentSnapshot cartSnapshot = await cartRef.get();
    // If the cart doesn't exist, create it with an empty map
    if (!cartSnapshot.exists) {
      await cartRef.set({}); // Initialize the cart document with an empty map
    }
  }

  // Update the quantity of a specific item in the cart
  Future<void> updateCartItemQuantity(String userId, String productId, int newQuantity) async {
    // Reference to the cart document
    final cartRef = _db.collection('carts').doc(_generateCartId(userId));

    // Reference to the specific cart item document
    final cartItemRef = cartRef.collection('items').doc(productId);

    // Check if the quantity is valid (non-negative)
    if (newQuantity <= 0) {
      // If the quantity is zero or less, remove the item from the cart
      await cartItemRef.delete();
    } else {
      // Update the quantity of the item in Firestore
      await cartItemRef.update({
        'quantity': newQuantity,
      });
    }
  }

  

  // Add item to the cart and create the cart document if it doesn't exist
  Future<void> addItemToCart(String userId, CartItemModel item) async {
    await ensureCartExists(userId); // Ensure the cart exists

    // Reference to the cart document
    final cartRef = _db.collection('carts').doc(_generateCartId(userId));

    // Reference to the cart item document within the user's cart
    final cartItemRef = cartRef.collection('items').doc(item.productId);

    // Check if the item already exists in the cart
    DocumentSnapshot docSnapshot = await cartItemRef.get();

    if (docSnapshot.exists) {
      // If it exists, update the quantity
      await cartItemRef.update({
        'quantity': FieldValue.increment(item.quantity),
      });
    } else {
      // If not, create a new item with all details
      await cartItemRef.set(item.toMap());
    }
  }

  // Remove item from cart
  Future<void> removeItemFromCart(String userId, String productId) async {
    await _db.collection('carts').doc(_generateCartId(userId)).collection('items').doc(productId).delete();
  }

  // Function to retrieve the cart items along with product details
 Future<List<Map<String, dynamic>>> getCartItemsWithDetails(String userId) async {
  await ensureCartExists(userId); // Ensure the cart exists

  QuerySnapshot cartSnapshot = await _db.collection('carts').doc(_generateCartId(userId)).collection('items').get();
  List<Map<String, dynamic>> cartItemsWithDetails = [];

  for (var doc in cartSnapshot.docs) {
    var cartItemData = doc.data() as Map<String, dynamic>;
    var cartItem = CartItemModel.fromFirestore(cartItemData);

    // Fetch additional product details
    var productDetails = await getProductDetails(cartItem.productId);

    // Create a map that includes cart item and product details
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

Future<Map<String, dynamic>> getProductDetails(String productId) async {
  // Reference to the products collection in Firestore
  DocumentSnapshot productSnapshot = await _db.collection('products').doc(productId).get();

  // Check if the product exists
  if (productSnapshot.exists) {
    // Convert the document data to a Map<String, dynamic>
    return productSnapshot.data() as Map<String, dynamic>;
  } else {
    throw Exception("Product not found");
  }
}

  // Check if the cart is empty
  Future<bool> isCartEmpty(String userId) async {
    await ensureCartExists(userId); // Ensure the cart exists

    final cartSnapshot = await _db.collection('carts').doc(_generateCartId(userId)).collection('items').get();
    return cartSnapshot.docs.isEmpty;
  }

  Future<void> updateCartItemCheckedStatus(String userId, String productId, bool isChecked) async {
  // Firestore query to update the `isChecked` status
  await FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('cart')
      .doc(productId)
      .update({'isChecked': isChecked});
}





  
}

