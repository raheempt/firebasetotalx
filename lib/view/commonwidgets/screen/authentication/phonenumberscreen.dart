
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebasetotalx/constants/apptextstyles.dart';
import 'package:firebasetotalx/providers/authprovider.dart';
import 'package:firebasetotalx/utils/validators.dart';
import 'package:firebasetotalx/view/commonwidgets/custombutton.dart';
import 'package:firebasetotalx/view/commonwidgets/customtextfiled.dart';
import 'package:firebasetotalx/view/commonwidgets/screen/authentication/otpscreen.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final size = MediaQuery.of(context).size;

    // ✅ Navigate after OTP is sent
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (authProvider.state == AuthState.otpSent) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => OtpScreen(
              verificationId: authProvider.verificationId,
            ),
          ),
        );
      }
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Image.asset(
                    'images/OBJECTS (1).jpg',
                    height: size.height * 0.25,
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Enter phone number',
                    style: AppTextStyles.subtitle,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    validator: (value) =>
                        ValidatorFunctions.phoneNumberValidate(value),
                    inputType: TextInputType.phone,
                    hintText: 'Enter phone number',
                    textEditingController: phoneNumberController,
                  ),
                  const SizedBox(height: 15),
                  const Text.rich(
                    TextSpan(
                      text: 'By continuing, I agree to TotalX\'s ',
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: 'terms and conditions',
                          style: TextStyle(color: Colors.cyan),
                        ),
                        TextSpan(
                          text: ' and ',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: 'privacy policy',
                          style: TextStyle(color: Colors.cyan),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 25),

                  // ✅ Show loading spinner or button
                  authProvider.state == AuthState.loading
                      ? const CircularProgressIndicator()
                      : CustomButtonBlack(
                          text: 'Get Otp',
                          btntxt: const Text(
                            'Get Otp',
                            style: AppTextStyles.button,
                          ),
                          ontap: () {
                            //exaplll
     Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => OtpScreen(
              verificationId: authProvider.verificationId,
            ),
          ),
        );

                            if (_formKey.currentState!.validate()) {
                              final phone =
                                  '+91${phoneNumberController.text.trim()}';
                              authProvider.sendOtp(phone);
                            }
                          },
                        ),

                  const SizedBox(height: 20),

                  // ✅ Show error message if any
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
        ),
      ),
    );
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    super.dispose();
  }
}
