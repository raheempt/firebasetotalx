
import 'package:eitherx/eitherx.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebasetotalx/model/usermodel.dart';
import 'package:firebasetotalx/developmentonly/customdebugger.dart';

class FirebaseService {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  FirebaseService({
    required this.auth,
    required this.firestore,
    required this.storage,
  });

  // 🔹 Send OTP to phone
  Future<void> loginWithPhone({
    required String phoneNumber,
    required Function(PhoneAuthCredential) verificationCompleted,
    required Function(FirebaseAuthException) verificationFailed,
    required Function(String, int?) codeSent,
    required Function(String) codeAutoRetrievalTimeout,
  }) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  // 🔹 Add a new user to Firestore
  Future<Either<String, void>> addUser(UserModel userModel) async {
    try {
      final User? user = auth.currentUser;
      if (user != null) {
        await firestore
            .collection('Users')
            .doc(user.uid)
            .collection('Userdata')
            .add(userModel.toMap());
        logInfo('User added successfully to Firestore for UID: ${user.uid}');
      } else {
        return const Left('No authenticated user found.');
      }
      return const Right(null);
    } catch (e) {
      logError('Error adding user: ${e.toString()}');
      return Left(e.toString());
    }
  }

  // 🔹 Get all users from Firestore
  Future<Either<String, List<UserModel>>> getUsers() async {
    try {
      logInfo('Fetching user data from Firestore...');
      final QuerySnapshot snapshot = await firestore
          .collection('Users')
          .doc(auth.currentUser?.uid)
          .collection('Userdata')
          .get();

      final List<UserModel> users = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return UserModel.fromMap(data);
      }).toList();

      logInfo('Successfully fetched ${users.length} users.');
      return Right(users);
    } catch (e) {
      logError('Error fetching users: ${e.toString()}');
      return Left(e.toString());
    }
  }

  // 🔹 Log out current user
  Future<Either<String, void>> logoutUser() async {
    try {
      await auth.signOut();
      logInfo('User signed out successfully.');
      return const Right(null);
    } catch (e) {
      logError('Error signing out: ${e.toString()}');
      return Left(e.toString());
    }
  }
}
