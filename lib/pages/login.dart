import 'dart:developer';

import 'package:cryptotrackerapp/pages/homepage.dart';
import 'package:cryptotrackerapp/pages/register.dart';
import 'package:cryptotrackerapp/provider/textfield-provider.dart';
import 'package:cryptotrackerapp/utils/utility.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  bool isLogging = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void loginUser() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(context, CupertinoPageRoute(
          builder: (context) {
            return const HomePage();
          },
        ));
      }
      log("User Logged");
    } on FirebaseAuthException catch (ex) {
      isLogging = false;
      setState(() {});
      log(ex.code.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    print("BUILD WIDGET");
    return Consumer<TextFieldProvider>(
      builder: (context, textFieldProvider, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          // backgroundColor: Colors.transparent,
          body: Column(children: [
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 60),
                    width: getDeviceWidth(context),
                    height: getDeviceHeight(context) / 2.5,
                    //  color: Colors.red,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Welcome to CryptoTracker!!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromARGB(255, 32, 13, 56),
                              fontWeight: FontWeight.bold,
                              fontSize: 33),
                        ),
                        Text(
                          "Track crytpo currency!!",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: textColor1, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      height: getDeviceHeight(context) / 2.5,
                      width: getDeviceWidth(context),
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      //   color: Colors.red,
                      child: Column(
                        children: [
                          TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              hintText: 'Email',
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 116, 114, 114),
                                    width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 116, 114, 114),
                                    width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                            child: Text(
                              textFieldProvider.emailErrorMessage,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.red),
                            ),
                          ),
                          TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              hintText: 'Password',
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 116, 114, 114),
                                    width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 116, 114, 114),
                                    width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                            child: Text(
                              textFieldProvider.passwordErrorMessage,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.red),
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
                                textFieldProvider.passwordValidation(
                                    passwordController.text);
                                if (textFieldProvider.emailIsValid &&
                                    textFieldProvider.passwordIsValid) {
                                  //print("VALID");
                                  loginUser();
                                } else {
                                  isLogging = false;
                                }
                              },
                              icon: isLogging
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ))
                                  : const Icon(Icons.arrow_forward),
                            ),
                          ),
                          // const SizedBox(
                          //   height: 20,
                          // ),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Don\'t have an account? ',
                                      style: TextStyle(
                                        // decoration: TextDecoration.underline,
                                        fontSize: 15,
                                        color: textColor1,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(context,
                                            CupertinoPageRoute(
                                          builder: (context) {
                                            return const MyRegister();
                                          },
                                        ));
                                        // Navigator.pushNamed(context, 'register');
                                      },
                                      child: Text(
                                        'Sign Up',
                                        style: TextStyle(
                                          // decoration: TextDecoration.underline,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: blueColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    //  decoration: TextDecoration.underline,
                                    fontSize: 15,
                                    color: blueColor,
                                  ),
                                ),
                              ]),
                        ],
                      )),
                ]),
          ]),
        );
      },
    );
  }
}
