import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';

class TextFieldProvider extends ChangeNotifier {
  bool emailIsValid = false;
  bool passwordIsValid = false;
  bool cpasswordIsValid = false;
  bool isConfirmPasswordMatch = false;
  bool isLogging = false;
  String emailErrorMessage = "";
  String passwordErrorMessage = "";
  String cpasswordErrorMessage = "";

  void emailValidation(String email) {
    if (email.isEmpty) {
      //check if email is empty
      emailIsValid = false;
      emailErrorMessage = "Email cannot be empty";
      notifyListeners();
    } else {
      if (!EmailValidator.validate(email)) {
        //check if email is valid
        emailIsValid = false;
        emailErrorMessage = "Please enter valid email address";
        notifyListeners();
      } else {
        emailIsValid = true;
        emailErrorMessage = "";
        notifyListeners();
      }
    }
  }

  void passwordValidation(String password) {
    if (password.isEmpty) {
      //check if password is empty
      passwordIsValid = false;
      passwordErrorMessage = "Password cannot be empty";
      notifyListeners();
    } else {
      if (password.length < 8) {
        //check if password is less than 8 lengtth
        passwordIsValid = false;
        passwordErrorMessage = "Password must be of 7 character";
        notifyListeners();
      } else {
        passwordIsValid = true;
        passwordErrorMessage = "";
        notifyListeners();
      }
    }
  }

  void cpasswordValidation(String cpassword, String password) {
    if (cpassword.isEmpty) {
      //check if password is empty
      cpasswordIsValid = false;
      cpasswordErrorMessage = "Confirm Password cannot be empty";
      notifyListeners();
    } else {
      if (cpassword.length < 8) {
        //check if password is less than 8 lengtth
        cpasswordIsValid = false;
        cpasswordErrorMessage = "Confirm Password must be of 7 character";
        notifyListeners();
      } else {
        if (password == cpassword) {
          cpasswordIsValid = true;
          cpasswordErrorMessage = "";
          isConfirmPasswordMatch = true;
          notifyListeners();
        } else {
          cpasswordIsValid = true;
          isConfirmPasswordMatch = false;
          cpasswordErrorMessage = "Confirm password must match with password";
          notifyListeners();
        }
      }
    }
  }
}
