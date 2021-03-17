import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class RegisterViewModel extends ChangeNotifier {
  final FirebaseAuth firebaseAuth;

  RegisterViewModel({@required this.firebaseAuth});

  bool _isLoading = false;
  bool _hasError = false;
  String _errorMessage;
  String _email;

  String get getEmail => this._email;
  bool get isLoading => this._isLoading;
  bool get hasError => this._hasError;
  String get errorMessage => this._errorMessage;

  Future<void> registerUser({
    @required String email,
    @required String password,
    @required String confirmPassword,
    String displayName,
  }) async {
    try {
      _hasError = false;
      _isLoading = true;
      _errorMessage = null;
      _email = email;
      notifyListeners();

      if (password != confirmPassword) {
        throw PasswordsDontMatchException();
      }

      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (displayName != null) {
        final user = firebaseAuth.currentUser;
        user.updateProfile(displayName: displayName);
      }
    } on FirebaseAuthException catch (e) {
      _hasError = true;
      switch (e.code) {
        case 'email-already-in-use':
          _errorMessage = 'This email is already in use';
          break;
        case 'invalid-email':
          _errorMessage = 'Email is not valid';
          break;
        case 'operation-not-allowed':
          _errorMessage = 'Email/Password account creation has not been setup';
          break;
        case 'weak-password':
          _errorMessage = 'Password entered is not strong enough';
          break;
        default:
      }
    } on PasswordsDontMatchException {
      _hasError = true;
      _errorMessage = 'The passwords entered do not match';
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  resetState() {
    _hasError = false;
    _isLoading = false;
    _errorMessage = null;
    _email = null;
  }
}

class PasswordsDontMatchException implements Exception {}
