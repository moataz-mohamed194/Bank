import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../error/error_text.dart';

class CheckNetwork{
  Future<void> connection() async {
    bool resultOfConnection = await InternetConnectionChecker().hasConnection;
    if(resultOfConnection != true) {
      MessageSnackBar(checkYourInternet.toString());
    }else{
      MessageSnackBar(loading.toString());
    }
  }

  }