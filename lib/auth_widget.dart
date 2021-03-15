import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers.dart';

class AuthWidget extends ConsumerWidget {
  final WidgetBuilder signedInBuilder;
  final WidgetBuilder signedOutBuilder;

  AuthWidget({
    @required this.signedInBuilder,
    @required this.signedOutBuilder,
  });

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final user = watch(authStateChangesProvider);

    //when the auth state changes, pop all pages to the root
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    });
    
    return user.when(
      data: (user) {
        //check if user is signed in or not and display appropriate page
        return user != null
            ? signedInBuilder(context)
            : signedOutBuilder(context);
      },
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (_, __) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Something went wrong'),
              const Text('Can\'t load data right now.'),
            ],
          ),
        ),
      ),
    );
  }
}
