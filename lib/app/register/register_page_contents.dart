import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../../common_widgets/auth_button.dart';
import '../../common_widgets/auth_text_field_widget.dart';
import 'register_view_model.dart';

class RegisterPageContents extends StatefulWidget {
  final RegisterViewModel viewModel;

  const RegisterPageContents({
    Key key,
    this.viewModel,
  }) : super(key: key);

  @override
  _RegisterPageContentsState createState() => _RegisterPageContentsState();
}

class _RegisterPageContentsState extends State<RegisterPageContents> {
  TextEditingController _emailTextEditingController;
  TextEditingController _passwordTextEditingController;
  TextEditingController _confirmPasswordTextEditingController;
  TextEditingController _usernameTextEditingController;

  @override
  void initState() {
    _emailTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();
    _confirmPasswordTextEditingController = TextEditingController();
    _usernameTextEditingController = TextEditingController();
    _emailTextEditingController.addListener(() {
      setState(() {});
    });
    _passwordTextEditingController.addListener(() {
      setState(() {});
    });
    _confirmPasswordTextEditingController.addListener(() {
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
    _confirmPasswordTextEditingController.dispose();
    widget.viewModel
        .resetState(); //when we close this screen, clear state in view model
    super.dispose();
  }

  _register() async {
    FocusScope.of(context).unfocus();
    await widget.viewModel.registerUser(
      email: _emailTextEditingController.text,
      password: _passwordTextEditingController.text,
      confirmPassword: _confirmPasswordTextEditingController.text,
      displayName: _usernameTextEditingController.text.isEmpty
          ? null
          : _usernameTextEditingController.text,
    );
  }

  bool _canRegister() {
    return _emailTextEditingController.text.isNotEmpty &&
        _passwordTextEditingController.text.isNotEmpty &&
        _confirmPasswordTextEditingController.text.isNotEmpty;
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
                  'Sign Up',
                  style: TextStyle(fontSize: 32),
                ),
                alignment: Alignment.centerLeft,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: AuthTextFieldWidget(
                labelText: '* Email',
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
                labelText: '* Password',
                hintText: 'Enter a password',
                textEditingController: _passwordTextEditingController,
                isPassword: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: AuthTextFieldWidget(
                labelText: '* Confirm password',
                hintText: 'Confirm password',
                textEditingController: _confirmPasswordTextEditingController,
                isPassword: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: AuthTextFieldWidget(
                labelText: 'Username',
                hintText: 'Username',
                textEditingController: _usernameTextEditingController,
                isPassword: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              child: AuthButton(
                onPressed: _register,
                onPressedEnabled: _canRegister,
                buttonText: 'Sign Up',
              ),
            ),
            SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Opacity(
                  opacity: 0.6,
                  child: Text("Already have an account?"),
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      color: Theme.of(context).buttonColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onTap: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
