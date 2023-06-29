import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:brew_crew/models/user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on FirebaseUser
  FirebaseUser? _userFromFirebaseUser(User user) {
    return FirebaseUser(uid: user.uid);
  }

  // auth change user stream
  Stream<FirebaseUser?> get user {
    return _auth.authStateChanges()
    .map((User? user) => user != null ? _userFromFirebaseUser(user) : null);
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
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch(e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  // register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
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

  // sign out
  Future signOut() async {
    try {
        return await _auth.signOut();
    } catch(e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }
}