import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/auth_widget.dart';
import 'app/home/home_page.dart';
import 'app/sign_in/sign_in_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.cyan[700],
        accentColor: Colors.amber,
        buttonColor: Colors.cyan[700],    
      ),
      home: AuthWidget(
        signedInBuilder: (_) => HomePage(),
        signedOutBuilder: (_) => SignInPage(),
      ),
    );
  }
}
