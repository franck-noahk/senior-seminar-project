import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_bulletin/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FStoredb {
  final String uid;
  FStoredb({this.uid});
  final CollectionReference users = Firestore.instance.collection('users');

  Future<dynamic> getData() async {
    return await users.document(uid).get();
  }
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

// Create user obj based on firebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return (user != null) ? User(uid: user.uid) : null;
  }

  //onChange stream
  Stream<User> get user {
    Stream<User> toReturn = _auth.onAuthStateChanged.map(_userFromFirebaseUser);
    toReturn.forEach((element) async {
      await element.getDataDb();
    });
    return toReturn;
  }

  //signin in with email
  Future signInEmail(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseUser user = result.user;
      User toReturn = _userFromFirebaseUser(user);
      if (toReturn != null) {
        // sleep(Duration(seconds: 3));
        await toReturn.getDataDb();
      }
      return toReturn;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {}
  }

  //register with email & password
  Future signUpEmail(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseUser user = result.user;
      User toReturn = _userFromFirebaseUser(user);
      if (toReturn != null) {
        sleep(Duration(seconds: 5));
        toReturn.getDataDb();
      }
      return toReturn;
    } catch (err) {
      print(err);
    }
  }
}
