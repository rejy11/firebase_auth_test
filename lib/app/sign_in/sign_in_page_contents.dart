import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

import '../../common_widgets/auth_button.dart';
import '../../common_widgets/auth_text_field_widget.dart';
import '../register/register_page.dart';
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

  bool _canSignIn() {
    if (_emailTextEditingController.text.isNotEmpty &&
        _passwordTextEditingController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: Align(
                child: Text(
                  'Sign In',
                  style: TextStyle(fontSize: 32),
                ),
                alignment: Alignment.centerLeft,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: AuthTextFieldWidget(
                labelText: 'Email',
                hintText: 'Enter your email',
                textEditingController: _emailTextEditingController,
                inputType: TextInputType.emailAddress,
                suffix:
                    EmailValidator.validate(_emailTextEditingController.text)
                        ? Icon(
                            Icons.check,
                            color: Colors.green,
                          )
                        : null,
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              child: AuthButton(
                onPressed: _signIn,
                onPressedEnabled: _canSignIn,
                buttonText: 'Sign In',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Opacity(
              opacity: 0.8,
              child: Text('Or'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              child: Container(
                width: 120,
                child: SignInButton(
                  Buttons.Google,
                  padding: EdgeInsets.all(5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  text: 'Sign In',
                  onPressed: widget.viewModel.signInWithGoogle,
                ),
              ),
            ),
            SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Opacity(
                  opacity: 0.6,
                  child: Text("Don't have an account?"),
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  child: Text(
                    'Create new one',
                    style: TextStyle(
                        color: Theme.of(context).buttonColor,
                        fontWeight: FontWeight.w700),
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return RegisterPage();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
