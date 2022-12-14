
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'domain/BankDataTextFieldProvider.dart';
import 'domain/GetDataOfBank.dart';
import 'domain/NoteDateProvider.dart';
import 'domain/RegistrationTextFieldProvider.dart';
import 'screens/Registration/login.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }catch(e){
    print(e);
  }
  FirebaseAuth.instance
      .authStateChanges()
      .listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print(user.uid);
    }
    runApp(MyApp(login: user));
  });

}

class MyApp extends StatelessWidget {
  final User? login;
  const MyApp({super.key, this.login});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RegistrationTextFieldProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BankDataTextFieldProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GetDataOfBank(),
        ),
        ChangeNotifierProvider(
          create: (context) => NoteDateProvider(),
        ),

      ],
      child: MaterialApp(
            title: 'Banking',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home:const LoginPage()
            ),
    );
  }
}
