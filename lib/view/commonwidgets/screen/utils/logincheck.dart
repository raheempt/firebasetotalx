 import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetotalx/view/commonwidgets/screen/authentication/user/homescreen.dart';
import 'package:firebasetotalx/view/commonwidgets/screen/authentication/otpscreen.dart';
import 'package:flutter/widgets.dart';

Widget handleAuth() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return const HomeScreen(); 
    } else {
      return const OtpScreen(verificationId: '',);
    }
  }