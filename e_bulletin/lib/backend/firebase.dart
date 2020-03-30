import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_bulletin/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FStoredb {
  final String uid;
  FStoredb({this.uid});
  final CollectionReference users = Firestore.instance.collection('users');

  Future<DocumentSnapshot> getData() async {
    return await users.document(uid).get();
  }

  Future<void> addFollower(String follower) async {
    print("Made it to firebase add follower");
    try {
      DocumentSnapshot currentData = await getData();
      List<dynamic> currentList = currentData.data['isFollowing'];
      print(currentData);
      print(currentList.toString());
      if (currentList != null) {
        currentList.add(follower);
      }
      await users.document(uid).setData({
        'isFollowing': currentList,
      }, merge: true);
    } catch (err) {
      print(err);
    }
  }

  Future<void> removeFollower(String follower) async {
    DocumentReference location = await users.document(uid);
    var locationData = await users.document(uid).get();
    int index = 0;
    List<dynamic> toUpdate = new List<dynamic>();
    for (var i = 0; i < locationData.data['isFollowing'].length; i++) {
      if (locationData.data['isFollowing'][i] != follower)
        toUpdate.add(locationData.data['isFollowing'][i]);
    }
    await location.setData({'isFollowing': toUpdate}, merge: true);
  }

  Stream<DocumentSnapshot> get document {
    Stream<DocumentSnapshot> toReturn = users.document(uid).get().asStream();
    return toReturn;
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
