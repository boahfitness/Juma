import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:juma/models/users/user.dart';
import './personalRecordService.dart';

class UserService {
  CollectionReference _userCollection = Firestore.instance.collection('users');

  Future<bool> createUser(User newUser) async {
    // need uid to make documentID
    if (newUser.uid.isEmpty || newUser.uid == null) return false;

    //set user data
    await _userCollection.document(newUser.uid).setData(newUser.toMap());

    //if there are tracked lifts, create new tracked lifts in db
    if (newUser.trackedLifts != null) {
      PersonalRecordService prService = PersonalRecordService(newUser.uid);
      newUser.trackedLifts.forEach((tl) async {
        await prService.createTrackedLift(tl);
      });
    }
    
    return true;
  }

  Future<User> getUserById(String uid) async {
    try {
      var doc = await _userCollection.document(uid).get();
      if (doc != null) {
        return User.fromMap(doc.data);
      }
      else {
        return null;
      }
    }
    catch (e) {
      print(e);
      return null;
    }
  }

}