import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Memeriksa apakah email sudah terdaftar
  Future<bool> emailExists(String email) async {
    final QuerySnapshot result = await _firestore
        .collection("users")
        .where("email", isEqualTo: email)
        .get();
    return result.docs.isNotEmpty; // Kembalikan true jika email ada
  }

  // SignUp User
  Future<String> signupUser({
    required String email,
    required String password,
    required String username,
    required String phoneNumber,
    required String address,
    double balance = 0.0,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        // Daftar pengguna di auth dengan email dan password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Tambahkan pengguna ke database Firestore
        await _firestore.collection("users").doc(cred.user!.uid).set({
          'uid': cred.user!.uid,
          'email': email,
          'username': username,
          'phoneNumber': phoneNumber,
          'address': address,
          'balance': balance,
        });

        res = "success";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  // LogIn user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        // Logging in user with email and password
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  // SignOut
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      // Handle error if needed
      print("Error signing out: $e");
    }
  }
}
