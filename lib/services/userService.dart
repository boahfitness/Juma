import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:juma/models/users/user.dart';

class UserService {
  CollectionReference _userCollection = Firestore.instance.collection('users');

  bool createUser(User newUser) {
    // need uid to make documentID
    if (newUser.uid.isEmpty || newUser.uid == null) return false;

    //set user data
    _userCollection.document(newUser.uid).setData(newUser.toMap());

    // set user tracked lifts

    return true;
  }
}