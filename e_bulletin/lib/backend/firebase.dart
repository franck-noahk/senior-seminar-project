import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_bulletin/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FStoredb {}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

// Create user obj based on firebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //onChange stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  //signin in with email
  Future signInEmail(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
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

}
