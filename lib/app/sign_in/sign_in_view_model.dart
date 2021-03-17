import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInViewModel with ChangeNotifier {
  final FirebaseAuth auth;

  SignInViewModel({@required this.auth});

  bool _isLoading = false;
  bool _hasError = false;
  String _errorMessage;
  String _email;
  String _password;
  UserCredential userCredential;

  bool get getIsLoading => this._isLoading;
  bool get getHasError => this._hasError;
  String get getErrorMessage => this._errorMessage;
  String get email => this._email;
  String get password => this._password;

  Future<void> signInWithEmailAndPassword({
    @required String email,
    @required String password,
  }) async {
    try {
      _hasError = false;
      _isLoading = true;
      _errorMessage = null;
      _email = email;
      _password = password;
      notifyListeners();
      userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _errorMessage = 'No user exists for email $email';
      } else if (e.code == 'wrong-password') {
        _errorMessage = 'An incorrect password has been provided';
      } else if (e.code == 'invalid-email') {
        _errorMessage = 'Email invalid';
      } else if (e.code == 'user-disabled') {
        _errorMessage = 'This user has been disabled';
      } else {
        _errorMessage = 'Unable to sign in. Error code: ${e.code}';
      }
      _hasError = true;
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      _isLoading = true;
      notifyListeners();
      userCredential = await auth.signInWithCredential(credential);
    } on Exception catch (e) {
      // TODO
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signInWithGitHub(BuildContext context) async {
    try {
      // Create a GitHubSignIn instance
      final GitHubSignIn gitHubSignIn = GitHubSignIn(
          clientId: 'c938d83b08bf9c63f25e',
          clientSecret: '2596f7b8f222877e038dca87135c5f7da266fb7f',
          redirectUrl:
              'https://fir-auth-test-bf4ec.firebaseapp.com/__/auth/handler');

      // Trigger the sign-in flow
      final result = await gitHubSignIn.signIn(context);

      // Create a credential from the access token
      final AuthCredential githubAuthCredential =
          GithubAuthProvider.credential(result.token);
      _isLoading = true;
      notifyListeners();
      // Once signed in, return the UserCredential
      userCredential = await auth.signInWithCredential(githubAuthCredential);
    } catch (e) {} finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
