import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers.dart';
import 'register_page_contents.dart';
import 'register_view_model.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('Register Page');
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Register'),
        ),
        body: ProviderListener<RegisterViewModel>(
          provider: registerModelProvider,
          onChange: (context, viewModel) async {
            if (viewModel.hasError) {
              return await showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text('Error'),
                  content: Text(viewModel.errorMessage),
                  actions: [
                    RaisedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            }
          },
          child: Consumer(
            builder: (context, watch, child) {
              final state = watch(registerModelProvider);
              return state.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : RegisterPageContents(viewModel: state);
            },
          ),
        ),
      ),
    );
  }
}
