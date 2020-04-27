import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_bulletin/backend/firebase.dart';

class User {
  final String uid;
  String email;
  bool isAdmin;
  String name;
  FStoredb db;
  String isAdminOf;
  List<String> isFollowing = new List<String>();
  //Constructor to build a user.
  User({this.uid}) {
    db = new FStoredb(uid: this.uid);
  }

//DEPRICATED: Async function to fill in user data from database. Issue was when to call async function. 
  Future<void> getDataDb() async {
    try {
      DocumentSnapshot result = await this.db.getData();
      if (result == null) {
        //Document does not exist
      }
      this.email = result.data['email'];
      this.isAdmin = result.data['isAdmin'];
      this.name = result.data['name'];
      this.isAdminOf = result.data['isAdminOf'];
    } catch (e) {
      print(e);
    }
  }

//Function to add followers. 
  Future<void> addFollower(String followerUID) async {
    try {
      await this.db.addFollower(followerUID);
    } catch (e) {
      print("\n\n" + e);
    }
  }

//Function to remove followers
  Future<void> removeFollower(String followerUID) async {
    try {
      await this.db.removeFollower(followerUID);
    } catch (e) {
      print("\n\n" + e.toString());
    }
  }

//Returns all followers
  Future<List<String>> getFollowers() async {
    try {
      List<String> toReturn = await this.db.getUsersFollowers(uid);
      if (toReturn != null) {
        return toReturn;
      } else {
        print("Error in users.dart get Followers was null");
      }
    } catch (e) {}
  }
}
