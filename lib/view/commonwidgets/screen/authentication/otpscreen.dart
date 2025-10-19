
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:provider/provider.dart';

import 'package:firebasetotalx/constants/appcolors.dart';
import 'package:firebasetotalx/constants/apptextstyles.dart';
import 'package:firebasetotalx/providers/authprovider.dart';
import 'package:firebasetotalx/view/commonwidgets/screen/authentication/user/homescreen.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;

  const OtpScreen({super.key, required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String otpCode = '';

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 🔹 App Image
              Image.asset(
                'images/Group (1).jpg',
                height: 140,
                width: 140,
              ),
              const SizedBox(height: 30),

              // 🔹 Title
              const Text(
                'OTP Verification',
                style: AppTextStyles.subtitle,
              ),
              const SizedBox(height: 10),

              const Text(
                'Enter the verification code sent to your number',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              /// 🔹 OTP input fields
              OtpTextField(
                borderColor: Colors.black38,
                focusedBorderColor: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10),
                contentPadding: const EdgeInsets.all(3),
                fieldHeight: size.width * 0.12,
                fieldWidth: size.width * 0.12,
                keyboardType: TextInputType.number,
                textStyle: const TextStyle(color: Colors.black),
                filled: true,
                fillColor: Colors.white,
                numberOfFields: 6,
                showFieldAsBox: true,
                onSubmit: (String verificationCode) {
                  otpCode = verificationCode;
                },
              ),

              const SizedBox(height: 25),

              // 🔹 Verify button / loader
              authProvider.state == AuthState.loading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        // exaplll
                           Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
          (route) => false,
        );
        //.....
                        if (otpCode.isEmpty || otpCode.length < 6) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please enter a valid 6-digit OTP'),
                            ),
                          );
                        } else {
                          authProvider.verifyOtp(
                            widget.verificationId,
                            otpCode.trim(),
                          );
                        }
                      },
                      child: const Text(
                        'Verify OTP',
                        style: AppTextStyles.button,
                      ),
                    ),

              const SizedBox(height: 20),

              // 🔹 Error Message
              
              if (authProvider.state == AuthState.error)
                Text(
                  authProvider.errorMessage,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                  
                ),
                
            ],
          ),
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final authProvider = context.watch<AuthProvider>();

    // ✅ Navigate to HomeScreen when verified successfully
    if (authProvider.state == AuthState.verified) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Phone verified successfully!')),
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
          (route) => true,
        );
      });
    }
  }
}
