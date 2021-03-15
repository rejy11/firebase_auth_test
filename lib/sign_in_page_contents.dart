import 'package:firebase_auth_test/hero_dialog_route.dart';
import 'package:firebase_auth_test/register_page.dart';
import 'package:flutter/material.dart';

import 'auth_text_field_widget.dart';
import 'sign_in_view_model.dart';

class SignInPageContents extends StatefulWidget {
  final SignInViewModel viewModel;

  const SignInPageContents({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  _SignInPageContentsState createState() => _SignInPageContentsState();
}

class _SignInPageContentsState extends State<SignInPageContents> {
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
    final email = widget.viewModel.email;

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

  _signIn() async {
    FocusScope.of(context).unfocus(); //close keyboard before
    await widget.viewModel.signInWithEmailAndPassword(
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
            hintText: 'Enter your password',
            textEditingController: _passwordTextEditingController,
            isPassword: true,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        RaisedButton(
          child: Text('Sign In'),
          onPressed: _emailTextEditingController.text.isNotEmpty &&
                  _passwordTextEditingController.text.isNotEmpty
              ? _signIn
              : null,
        ),
        Text('Or'),
        Hero(
          tag: 'RegisterButtonHero',
          child: RaisedButton(
            child: Text('Register'),
            onPressed: () => Navigator.of(context).push(HeroDialogRoute(
              builder: (context) {
                return RegisterPage();
              },
            )
                // MaterialPageRoute(
                //   builder: (context) {
                //     return RegisterPage();
                //   },
                // ),
                ),
          ),
        ),
        RaisedButton(
          child: Text('Google'),
          onPressed: widget.viewModel.signInWithGoogle,
        ),
      ],
    );
  }
}
