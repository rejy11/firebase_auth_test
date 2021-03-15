import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_test/register_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'sign_in_view_model.dart';

final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);

final authStateChangesProvider = StreamProvider<User>(
    (ref) => ref.watch(firebaseAuthProvider).authStateChanges());

final signInModelProvider = ChangeNotifierProvider<SignInViewModel>(
  (ref) => SignInViewModel(auth: ref.watch(firebaseAuthProvider)),
);

final registerModelProvider = ChangeNotifierProvider<RegisterViewModel>(
  (ref) => RegisterViewModel(firebaseAuth: ref.watch(firebaseAuthProvider)),
);
