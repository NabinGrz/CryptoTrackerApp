import 'package:cryptotrackerapp/pages/verification-code.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInWithPhone extends StatefulWidget {
  const SignInWithPhone({Key? key}) : super(key: key);

  @override
  State<SignInWithPhone> createState() => _SignInWithPhoneState();
}

class _SignInWithPhoneState extends State<SignInWithPhone> {
  TextEditingController phoneNumController = TextEditingController();
  void sendOTP() async {
    String phoneNumber = "+977${phoneNumController.text.trim()}";
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (credential) {},
        verificationFailed: (ex) {},
        codeSent: (verificationID, resendToken) {
          Navigator.push(context, CupertinoPageRoute(
            builder: (context) {
              return VerifyOTPPage(
                verificationID: verificationID,
              );
            },
          ));
        },
        codeAutoRetrievalTimeout: (verificationID) {},
        timeout: const Duration(seconds: 30));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              maxLength: 10,
              controller: phoneNumController,
              decoration: InputDecoration(
                fillColor: Colors.grey.shade100,
                filled: true,
                hintText: 'Phone-Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  sendOTP();
                },
                child: const Text("Sign In"))
          ],
        ),
      ),
    );
  }
}
