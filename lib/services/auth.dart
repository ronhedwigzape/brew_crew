import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:brew_crew/models/user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on FirebaseUser
  FirebaseUser? _userFromFirebaseUser(User user) {
    return user != null ? FirebaseUser(uid: user.uid) : null;
  }


  // sign in anon
  Future signInAnon() async {

    try {

      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      if (result.user != null) {
        return _userFromFirebaseUser(user!);
      }

    } catch(e) {

      if (kDebugMode) {
        print(e.toString());
      }
      return null;

    }

  }

  // sign in with email & password

  // register with email & password

  // sign out

}