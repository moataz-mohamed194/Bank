
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class Registration {
  Future<String> createAccount(String emailAddress, String password)async{
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return '';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.code.toString();
    } catch (e) {
      return e.toString();
    }

  }

  Future logOutAccount()async{
    try{
      await FirebaseAuth.instance.signOut();
      return true;
    }catch(e){
      return false;
    }
  }

  Future<String?> signInAccount(String emailAddress, String password)async{
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress,
          password: password
      );
      print('done-$credential');
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }else{
        return e.code.toString();
      }
    }catch (e) {
      return e.toString();
    }
  }

}