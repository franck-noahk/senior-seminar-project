import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_bulletin/backend/firebase.dart';

class User {
  final String uid;
  String email;
  bool isAdmin;
  String name;
  FStoredb db;
  List<String> isFollowing = new List<String>();

  User({this.uid}) {
    db = new FStoredb(uid: this.uid);
  }

  Future<void> getDataDb() async {
    try {
      DocumentSnapshot result = await this.db.getData();
      if (result == null) {
        //Document does not exist
      }
      this.email = result.data['email'];
      this.isAdmin = result.data['isAdmin'];
      this.name = result.data['name'];
      // this.isFollowing = result.data['isFollowing'];
      print("\n\n\n" + this.email + "\n\n\n");
      print(this.isFollowing);
    } catch (e) {
      print(e);
    }
  }

  Future<void> addFollower(String followerUID) async {
    try {
      await this.db.addFollower(followerUID);
    } catch (e) {
      print("\n\n" + e);
    }
  }

  Future<void> removeFollower(String followerUID) async {
    try {
      await this.db.removeFollower(followerUID);
    } catch (e) {
      print("\n\n" + e.toString());
    }
  }
}
