import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:juma/models/users/user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user) {
    return user == null ? null 
    : User(uid: user.uid);
  }

  // on auth changed user stream
  Stream<FirebaseUser> get user {
    return _auth.onAuthStateChanged;
  }

  Future<String> registerWithEmailAndPassword(String email, String password) async {
    try {
      var result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return result.user.uid;
    }
    on PlatformException catch(e) {
      throw e;
    }
    catch (e) {
      print(e.toString());
      return null;
    }
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
  Future<dynamic> signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult rs = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = rs.user;
      return _userFromFirebaseUser(user);
    }
    catch (e) {
      print(e.toString());
      return null;
    }
  }

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