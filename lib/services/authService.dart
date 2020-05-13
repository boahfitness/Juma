import 'package:firebase_auth/firebase_auth.dart';
import 'package:juma/models/users/user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user) {
    return user == null ? null : new User(uid: user.uid);
  }

  // on auth changed user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  // sign in anom
  Future signInAnon() async {
    try {
      AuthResult rs = await _auth.signInAnonymously();
      FirebaseUser user = rs.user;
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password

  // register with email and password

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

}