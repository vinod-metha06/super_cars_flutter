import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Service {
  var mail = FirebaseAuth.instance.currentUser?.email;
  final db = FirebaseFirestore.instance;
  Future<void> emailMethod() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    mail = prefs.getString("email");
  }

  Future<bool> register(
      username, emailAddress, password, BuildContext context) async {
    print("called");
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress.toString().trim(),
        password: password.toString().trim(),
      );
      await createUser(
          credential.user!.uid, username, emailAddress.toString().trim());
      return true;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.code == 'weak-password'
              ? "The password provided is too weak."
              : "The account already exists for that email.")));
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> login(emailAddress, password, BuildContext context) async {
    print("called");
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress.toString().trim(),
          password: password.toString().trim());

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Succes")));
      return true;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.code == 'user-not-found'
              ? "No user found for that email"
              : "wrong-password")));
    }

    return false;
  }

  Future<void> createUser(String uid, String username, String email) async {
    await db
        .collection("users")
        .doc(uid)
        .set({'name': username, 'email': email, 'pic': ''});
  }

  Future<void> addWishlist(String name, String image, String price, String id,
      BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString("email");
    String v = email! + id;
    await db.collection("wishlist").doc(v).set({
      'email': email.toString().trim(),
      'name': name,
      'image': image,
      'price': price,
      'id': v
    }, SetOptions(merge: true)).whenComplete(() => ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Added..."))));
  }

  Future<void> deleteWish(String id, BuildContext context) async {
    db.collection("wishlist").doc(id).delete().then(
          (doc) => ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Deleted..."))),
          onError: (e) => print("Error updating document $e"),
        );
  }

  Stream<QuerySnapshot> luxuryCarStream = FirebaseFirestore.instance
      .collection('cars')
      .where("type", isEqualTo: "Luxury")
      .snapshots();

  Stream<QuerySnapshot> wishlistCarStream = FirebaseFirestore.instance
      .collection('wishlist')
      .where("email", isEqualTo: FirebaseAuth.instance.currentUser?.email)
      .snapshots();
}
