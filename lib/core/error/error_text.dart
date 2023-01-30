
import 'package:flutter/material.dart';
import 'package:get/get.dart';

String loading = 'Loading.....';

String checkYourInternet = 'check your Internet connection';

String checkYourData = 'check your Data you enter';

String failedToGetData = 'failed To Get Data';

String failedTheAction = 'failed the action';

class MessageSnackBar {
  // MessageSnackBar(String string);

  MessageSnackBar(String message) {
    Get.snackbar(
      "Message",
      "$message",
      icon: Icon(Icons.message, color: Colors.white),
      snackPosition: SnackPosition.BOTTOM,

    );
  }
}