import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
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
}
