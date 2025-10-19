// import 'package:firebasetotalx/services/firebaseservices.dart';
// import 'package:flutter/material.dart';
// enum AuthState{signedIn,signedOut,error}
// class SignOutProvider with ChangeNotifier{
// final FirebaseService firebaseService;
// SignOutProvider({required this.firebaseService});
// AuthState _state=AuthState.signedIn;
// String _errorMessage = '';
// String get errorMessage => _errorMessage;
// AuthState get state => _state;
// Future<void> signOutUser()async{
// if(firebaseService.auth.currentUser!=null){
//   final response=await firebaseService.logoutUser();
//   response.fold((left){
//     _state=AuthState.error;
//     _errorMessage=left;
//   }, (right){
//     _state=AuthState.signedOut;
//   });
// }
// notifyListeners();
// }
// }
// lib/providers/signoutprovider.dart
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
