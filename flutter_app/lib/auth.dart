import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';


abstract class BaseAuth {
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password);
  Future<String> currentUser();
  Future<String> currentUseremail();
  Future<String> currentUsername();
  Future<void> signOut();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return user?.uid;
  }

  Future<String> createUserWithEmailAndPassword(
      String email, String password) async {
    FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return user?.uid;
  }

  Future<String> currentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user?.uid;

  }

  Future<String> currentUseremail() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user?.email;

  }
  Future<String> currentUsername() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user?.displayName;

  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}