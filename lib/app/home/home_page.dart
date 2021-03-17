import 'package:firebase_auth_test/app/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseAuth = context.read(firebaseAuthProvider);
    final user = firebaseAuth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(user.email),
            RaisedButton(
              child: Text('Log Out'),
              onPressed: () async {
                try {
                  await GoogleSignIn().signOut();
                  await firebaseAuth.signOut();
                } on Exception catch (e) {
                  print(e);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
