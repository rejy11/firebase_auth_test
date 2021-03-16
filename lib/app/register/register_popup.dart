import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common_widgets/auth_text_field_widget.dart';
import '../extensions/custom_rect_tween.dart';
import '../providers.dart';
import 'register_view_model.dart';

class RegisterPopupCard extends StatefulWidget {
  @override
  _RegisterPopupCardState createState() => _RegisterPopupCardState();
}

class _RegisterPopupCardState extends State<RegisterPopupCard> {
  TextEditingController _emailTextEditingController;
  TextEditingController _passwordTextEditingController;
  RegisterViewModel _viewModel;

  @override
  void initState() {
    _emailTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();
    _emailTextEditingController.addListener(() {
      setState(() {});
    });
    _passwordTextEditingController.addListener(() {
      setState(() {});
    });
    _viewModel = context.read(registerModelProvider);
    //read the email from our viewmodel
    final email = _viewModel.getEmail;

    //if an email has previously been entered, retain it
    if (email != null && email.isNotEmpty) {
      _emailTextEditingController.text = email;
    }
    super.initState();
  }

  @override
  void dispose() {
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    _viewModel.resetState();
    super.dispose();
  }

  _register() async {
    //FocusScope.of(context).unfocus();
    await _viewModel.registerUser(
      email: _emailTextEditingController.text,
      password: _passwordTextEditingController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'Hero',
      createRectTween: (begin, end) {
        return CustomRectTween(begin: begin, end: end);
      },
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Material(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Register',
                            style: TextStyle(fontSize: 24),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 30),
                            child: AuthTextFieldWidget(
                              labelText: 'Email',
                              hintText: 'Enter your email',
                              textEditingController:
                                  _emailTextEditingController,
                              inputType: TextInputType.emailAddress,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 30),
                            child: AuthTextFieldWidget(
                              labelText: 'Password',
                              hintText: 'Enter a password',
                              textEditingController:
                                  _passwordTextEditingController,
                              isPassword: true,
                            ),
                          ),
                          Consumer(
                            builder: (context, watch, child) {
                              final viewModel = watch(registerModelProvider);
                              if (viewModel.hasError) {
                                return Text(viewModel.errorMessage);
                              }
                              return SizedBox();
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RaisedButton(
                            child: Text('Register'),
                            onPressed:
                                _emailTextEditingController.text.isNotEmpty &&
                                        _passwordTextEditingController
                                            .text.isNotEmpty
                                    ? _register
                                    : null,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
