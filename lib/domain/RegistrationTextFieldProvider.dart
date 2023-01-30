
import 'package:flutter/material.dart';
import '../core/error/error_text.dart';
import '../core/network/check_network.dart';
import '../data/Registration.dart';
import '../data/model/ValidationItem.dart';


class RegistrationTextFieldProvider extends ChangeNotifier {
  ValidationItem emailData = ValidationItem(null, null);
  ValidationItem passwordData = ValidationItem(null, null);
  ValidationItem repeatPasswordData = ValidationItem(null, null);

  ValidationItem get email => emailData;
  ValidationItem get password => passwordData;
  ValidationItem get repeatPassword => repeatPasswordData;

  void changeEmail(String value) {
    if (value.contains(RegExp(r"^\S+@\S+\.\S+$")) == true) {
      emailData = ValidationItem(value, null);
    } else {
      emailData = ValidationItem(null, "must be longer and check your email");
    }
    notifyListeners();
  }

  void changePassword(String value) {
    bool passwordValid0 = RegExp(r"[a-z]").hasMatch(value);
    bool passwordValid1 = RegExp(r"[A-Z]").hasMatch(value);
    bool passwordValid2 = RegExp(r"[0-9]").hasMatch(value);
    bool passwordValid3 = RegExp(r"[.!#$%&'*+-/=?^_`{|}~]").hasMatch(value);
    if(value.length < 8){
      passwordData =
          ValidationItem(null, "the password must be more than 8 digits");
    }
    if(passwordValid0 == false){
      passwordData =
          ValidationItem(null, "the password must have small letters");
    }
    if(passwordValid1 == false){
      passwordData =
          ValidationItem(null, "the password must have upper letters");
    }
    if(passwordValid2 == false){
      passwordData =
          ValidationItem(null, "the password must have numbers");
    }
    if(passwordValid3 == false){
      passwordData =
          ValidationItem(null, "the password must have +-=*{}");
    }
    if (passwordValid0 == true &&
        passwordValid1 == true &&
        passwordValid2 == true &&
        passwordValid3 == true &&
        value.length >= 8) {
      passwordData = ValidationItem(value, null);
    } else {
      if(value.length < 8){
        passwordData =
            ValidationItem(null, "the password must be more than 8 digits");
      }
      else if(passwordValid0 == false){
        passwordData =
            ValidationItem(null, "the password must have small letters");
      }
      else if(passwordValid1 == false){
        passwordData =
            ValidationItem(null, "the password must have upper letters");
      }
      else if(passwordValid2 == false){
        passwordData =
            ValidationItem(null, "the password must have numbers");
      }
      else if(passwordValid3 == false){
        passwordData =
            ValidationItem(null, "the password must have +-=*{}");
      }
      else{
      passwordData =
          ValidationItem(null, "the password must be more than 8 digits and has upper char and small and +-=*{}");
      }
    }
    notifyListeners();
  }

  Future<bool> get signInIsValid async {
    if (emailData.value != null && passwordData.value != null) {
      CheckNetwork().connection();
      String? result = await Registration().signInAccount(emailData.value.toString(), passwordData.value.toString());
      if (result == null){
        return true;
      }else{
        MessageSnackBar(result.toString());
        return false;
      }
    }
    else {
      if (emailData.value == null){
        emailData = ValidationItem(null, "must be longer and check your email");
      }
      if (passwordData.value == null){
        passwordData =
            ValidationItem(null, "the password must be more than 8 digits and has upper char and small and +-=*{}");

      }
      notifyListeners();

      return false;
    }
  }

  void changeRepeatPassword(String value){
    if (passwordData.value == value) {
      repeatPasswordData = ValidationItem(value, null);
    } else {
      repeatPasswordData = ValidationItem(null, "the passwords are not same");
    }
    notifyListeners();
  }

  Future<bool> get signUpIsValid async {
    CheckNetwork().connection();

    if (emailData.value != null && passwordData.value != null && repeatPasswordData.value != null) {
      String? result = await Registration().createAccount(emailData.value.toString(), passwordData.value.toString());
      if (result == null){
        return true;
      }else{
        MessageSnackBar(result.toString());
        return false;
      }
    }
    else {
      MessageSnackBar(failedTheAction.toString());
      return false;
    }
  }

  Future<bool> get checkIfLogOut async{
    CheckNetwork().connection();

    if (await Registration().logOutAccount()==true){
      return true;
    }else{
      MessageSnackBar(failedTheAction.toString());
      return false;
    }
  }

}
