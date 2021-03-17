import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common_widgets/loading_overlay_widget.dart';
import '../providers.dart';
import 'register_page_contents.dart';
import 'register_view_model.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('RegisterPage');

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
                final state = watch(registerModelProvider);
                return Stack(
                  children: [
                    RegisterPageContents(viewModel: state),
                    state.isLoading ? LoadingOverlay() : SizedBox(),
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