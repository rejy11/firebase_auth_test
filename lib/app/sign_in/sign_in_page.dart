import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common_widgets/loading_overlay_widget.dart';
import '../providers.dart';
import 'sign_in_page_contents.dart';
import 'sign_in_view_model.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('SignInPage');

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: ProviderListener<SignInViewModel>(
          provider: signInModelProvider,
          onChange: (context, viewModel) async {
            if (viewModel.getHasError) {
              return await showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text('Error'),
                  content: Text(viewModel.getErrorMessage),
                  actions: [
                    RaisedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            }
          },
          child: SafeArea(
            child: Consumer(
              builder: (context, watch, child) {
                final state = watch(signInModelProvider);
                return Stack(
                  children: [
                    SignInPageContents(viewModel: state),
                    state.getIsLoading ? LoadingOverlay() : SizedBox(),
                  ],
                );                
              },
            ),
          ),
        ),
      ),
    );
  }
}
