import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    Key key,
    @required this.onPressed,
    @required this.buttonText,
    @required this.onPressedEnabled,
  }) : super(key: key);

  final Function onPressed;
  final Function onPressedEnabled;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      child: RaisedButton(
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 16),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        onPressed: onPressedEnabled() ? onPressed : null,
      ),
    );
  }
}
