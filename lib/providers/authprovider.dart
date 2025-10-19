
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

enum AuthState { idle, loading, verified, error, otpSent }

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthState _state = AuthState.idle;
  AuthState get state => _state;

  String _verificationId = '';
  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  /// 🔹 Step 1: Send OTP
  Future<void> sendOtp(String phoneNumber) async {
    _state = AuthState.loading;
    notifyListeners();

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto verification (Android)
        await _auth.signInWithCredential(credential);
        _state = AuthState.verified;
        notifyListeners();
      },
      verificationFailed: (FirebaseAuthException e) {
        _state = AuthState.error;
        _errorMessage = e.message ?? 'Verification failed';
        notifyListeners();
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
        _state = AuthState.idle;
        notifyListeners();
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  /// 🔹 Step 2: Verify OTP
  Future<void> verifyOtp(String verificationId, String smsCode) async {
    _state = AuthState.loading;
    notifyListeners();

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      await _auth.signInWithCredential(credential);

      _state = AuthState.verified;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      _state = AuthState.error;
      _errorMessage = e.message ?? 'Invalid OTP';
      notifyListeners();
    } catch (e) {
      _state = AuthState.error;
      _errorMessage = 'Something went wrong. Try again.';
      notifyListeners();
    }
  }

  String get verificationId => _verificationId;
}
