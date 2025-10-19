
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../model/usermodel.dart';

// enum HomeScreenState { loading, loaded, error }

// class HomeScreenProvider with ChangeNotifier {
//   HomeScreenState _state = HomeScreenState.loading;
//   HomeScreenState get state => _state;

//   List<UserModel> _users = [];
//   List<UserModel> get users => _users;

//   String _errorMessage = '';
//   String get errorMessage => _errorMessage;

//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<void> getAllUsers() async {
//     _state = HomeScreenState.loading;
//     notifyListeners();

//     try {
//       final snapshot = await _firestore.collection('users').get();
//       _users = snapshot.docs
//           .map((doc) => UserModel.fromMap(doc.data()))
//           .toList();

//       _state = HomeScreenState.loaded;
//     } catch (e) {
//       _errorMessage = e.toString();
//       _state = HomeScreenState.error;
//     }

//     notifyListeners();
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/usermodel.dart';

enum HomeScreenState { loading, loaded, error }

class HomeScreenProvider with ChangeNotifier {
  HomeScreenState _state = HomeScreenState.loading;
  HomeScreenState get state => _state;

  List<UserModel> _users = [];
  List<UserModel> get users => _users;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> getAllUsers() async {
    _state = HomeScreenState.loading;
    notifyListeners();

    try {
      final snapshot = await _firestore.collection('users').get();

      _users = snapshot.docs
          .map((doc) => UserModel.fromMap(doc.data()))
          .toList();

      _state = HomeScreenState.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _state = HomeScreenState.error;
    }

    notifyListeners();
  }

  /// 🔹 Add a new user to Firestore
  Future<void> addNewUser(UserModel user) async {
    try {
      await _firestore.collection('users').add(user.toMap());

      // After successful add, update local list instantly
      _users.add(user);

      // Notify UI about the new user
      _state = HomeScreenState.loaded;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _state = HomeScreenState.error;
      notifyListeners();
    }
  }
}
