import 'dart:developer';

import 'package:cryptotrackerapp/pages/login.dart';
import 'package:cryptotrackerapp/provider/textfield-provider.dart';
import 'package:cryptotrackerapp/utils/utility.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  bool isLogging = false;

  void creatAccount() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmpasswordController.text.trim();
    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      log("Please enter details");
    } else if (password != confirmPassword) {
      log("Password do not match");
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        if (userCredential.user != null) {
          Navigator.pop(context);
        }
        log("User created");
      } on FirebaseAuthException catch (ex) {
        isLogging = false;
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(ex.code.toString()),
        ));
        log(ex.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TextFieldProvider>(
      builder: (context, textFieldProvider, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          // backgroundColor: Colors.transparent,
          body: Column(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                margin: const EdgeInsets.only(left: 15, top: 40, bottom: 30),
                // padding: const EdgeInsets.only(left: 35, top: 80),
                child: Text(
                  "Get Started",
                  style: TextStyle(
                      color: textColor1,
                      fontSize: 33,
                      fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: getDeviceHeight(context) / 1.5,
                width: getDeviceWidth(context),
                margin: const EdgeInsets.symmetric(horizontal: 15),
                // color: Colors.red,
                child: Column(
                  children: [
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 116, 114, 114),
                              width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 116, 114, 114),
                              width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        hintText: 'Email',
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      child: Text(
                        textFieldProvider.emailErrorMessage,
                        style: const TextStyle(fontSize: 12, color: Colors.red),
                      ),
                    ),
                    TextField(
                      // obscureText: true,
                      controller: passwordController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 116, 114, 114),
                              width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 116, 114, 114),
                              width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        hintText: 'Password',
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      child: Text(
                        textFieldProvider.passwordErrorMessage,
                        style: const TextStyle(fontSize: 12, color: Colors.red),
                      ),
                    ),
                    TextField(
                      controller: confirmpasswordController,
                      //obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 116, 114, 114),
                              width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 116, 114, 114),
                              width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        hintText: 'Confirm Password',
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      child: Text(
                        textFieldProvider.cpasswordErrorMessage,
                        style: const TextStyle(fontSize: 12, color: Colors.red),
                      ),
                    ),
                    Container(
                      height: getDeviceHeight(context) / 16,
                      width: getDeviceWidth(context) / 2,
                      decoration: BoxDecoration(
                        color: blueColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      child: IconButton(
                        color: Colors.white,
                        onPressed: () async {
                          isLogging = true;
                          textFieldProvider
                              .emailValidation(emailController.text);
                          textFieldProvider
                              .passwordValidation(passwordController.text);
                          textFieldProvider.cpasswordValidation(
                              confirmpasswordController.text,
                              passwordController.text);
                          if (textFieldProvider.emailIsValid &&
                              textFieldProvider.passwordIsValid &&
                              textFieldProvider.cpasswordIsValid &&
                              textFieldProvider.isConfirmPasswordMatch) {
                            creatAccount();
                          } else {
                            isLogging = false;
                          }
                        },
                        icon: isLogging
                            ? const Center(
                                child: CircularProgressIndicator(
                                color: Colors.white,
                              ))
                            : const Text("Sign Up",
                                style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(context, CupertinoPageRoute(
                          builder: (context) {
                            return const MyLogin();
                          },
                        ));
                      },
                      child: Text(
                        'Already have an account?',
                        style: TextStyle(
                          //decoration: TextDecoration.underline,
                          fontSize: 15,
                          color: textColor1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ]),
        );
      },
    );
  }
}
