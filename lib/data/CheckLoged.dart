
import 'package:firebase_auth/firebase_auth.dart';

class CheckLogged {
  String? uid;

  Future<String?> changeChecked() async {
    await FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) async {
          if (user != null) {
            uid = user.uid;
          }
        });

    return uid;
  }
}