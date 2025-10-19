
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum AuthState { signedIn, signedOut, signingOut }

class SignOutProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthState _state = AuthState.signedIn;

  AuthState get state => _state;

  Future<void> signOut() async {
    _state = AuthState.signingOut;
    notifyListeners();

    try {
      await _auth.signOut();
      _state = AuthState.signedOut;
    } catch (e) {
      _state = AuthState.signedIn; // remain signed in if error
    }

    notifyListeners();
  }
}
