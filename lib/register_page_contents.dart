import 'package:firebase_auth_test/register_view_model.dart';
import 'package:flutter/material.dart';

import 'auth_text_field_widget.dart';

class RegisterPageContents extends StatefulWidget {
  final RegisterViewModel viewModel;

  const RegisterPageContents({Key key, @required this.viewModel})
      : super(key: key);

  @override
  _RegisterPageContentsState createState() => _RegisterPageContentsState();
}

class _RegisterPageContentsState extends State<RegisterPageContents> {
  TextEditingController _emailTextEditingController;
  TextEditingController _passwordTextEditingController;

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
    //read the email from our viewmodel
    final email = widget.viewModel.getEmail;

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
    super.dispose();
  }

  _register() async {
    //FocusScope.of(context).unfocus();
    await widget.viewModel.registerUser(
      email: _emailTextEditingController.text,
      password: _passwordTextEditingController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: AuthTextFieldWidget(
            labelText: 'Email',
            hintText: 'Enter your email',
            textEditingController: _emailTextEditingController,
            inputType: TextInputType.emailAddress,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: AuthTextFieldWidget(
            labelText: 'Password',
            hintText: 'Enter a password',
            textEditingController: _passwordTextEditingController,
            isPassword: true,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        RaisedButton(
          child: Text('Register'),
          onPressed: _emailTextEditingController.text.isNotEmpty &&
                  _passwordTextEditingController.text.isNotEmpty
              ? _register
              : null,
        ),
      ],
    );
  }
}
