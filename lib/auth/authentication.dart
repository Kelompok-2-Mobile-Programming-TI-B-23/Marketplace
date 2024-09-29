import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // SignUp User

  Future<String> signUpUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // register user in auth with email and password
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        // add user to your  firestore database
        print(credential.user!.uid);
        await _firestore.collection("users").doc(credential.user!.uid).set({
          'uid': credential.user!.uid,
          'email': email,
        });

        res = "success";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  // logIn user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      // logging in user with email and password
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      res = "success";
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  // for sighout
  signOut() async {
    // await _auth.signOut();
  }
}
