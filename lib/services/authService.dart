import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/services.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      "email",
      "https://www.googleapis.com/auth/drive.file",
    ]
  );

  // on auth changed user stream
  Stream<FirebaseUser> get user {
    return _auth.onAuthStateChanged;
  }

  // register with email and password
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
  Future<String> signInAnon() async {
    try {
      AuthResult rs = await _auth.signInAnonymously();
      return rs.user.uid;
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future<String> signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult rs = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return rs.user.uid;
    }
    catch (e) {
      print(e.toString());
      return null;
    }
  }

  // google sign in
  Future<String> signInWithGoogle() async {
    try {
      GoogleSignInAccount googleAccount = await _googleSignIn.signIn().catchError((err) => null);
      if (googleAccount == null) return null;

      GoogleSignInAuthentication accountCreds = await googleAccount.authentication;

      // cases:
        // no account at all - error, go to sign up
        // account with google set up - sign in with creds
        // account without google set up - link account and sign in
      var signInMethods = await _auth.fetchSignInMethodsForEmail(email: googleAccount.email);

      if (signInMethods.length == 0) {
        _googleSignIn.signOut();
        throw PlatformException(code: 'INVALID_ACCOUNT', message: 'google account does not exist in the system');
      }
      else if (signInMethods.contains('google.com')) {
        var result = await _auth.signInWithCredential(
          GoogleAuthProvider.getCredential(idToken: accountCreds.idToken, accessToken: accountCreds.accessToken)
        );
        return result.user.uid;
      }
      else {
        throw PlatformException(code: 'ACCOUNT_NOT_LINKED', message: 'Account already exists but google account not linked');
      }
    }
    catch (e) {
      print(e);
      return null;
    }
  }

  // google sign up
  Future<String> signUpWithGoogle() async {
    try {
      GoogleSignInAccount googleAccount = await _googleSignIn.signIn().catchError((err) => null);
      if (googleAccount == null) return null;

      GoogleSignInAuthentication accountCreds = await googleAccount.authentication;

      //cases:
        // no account at all - create account with sign in with cred
        // account with google set up - error, account already exists
        // acocount without google set up - error, account already exists
      var signInMethods = await _auth.fetchSignInMethodsForEmail(email: googleAccount.email);

      if (signInMethods.length == 0) {
        var result = await _auth.signInWithCredential(
          GoogleAuthProvider.getCredential(idToken: accountCreds.idToken, accessToken: accountCreds.accessToken)
        );
        return result.user.uid;
      }
      else {
        throw PlatformException(code: 'ACCOUNT_ALREADY_EXISTS', message: 'A Juma account already exists with this email');
      }
    }
    catch (e) {
      print(e);
      return null;
    }
  }

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