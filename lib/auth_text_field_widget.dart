import 'package:flutter/material.dart';

class AuthTextFieldWidget extends StatefulWidget {
  AuthTextFieldWidget({
    Key key,
    @required this.labelText,
    @required this.hintText,
    @required this.textEditingController,
    this.isPassword,
    this.inputType,
  }) : super(key: key);

  final String labelText;
  final String hintText;
  final TextEditingController textEditingController;
  final bool isPassword;
  final TextInputType inputType;

  @override
  _AuthTextFieldWidgetState createState() => _AuthTextFieldWidgetState();
}

class _AuthTextFieldWidgetState extends State<AuthTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textEditingController,
      obscureText: widget.isPassword == null ? false : widget.isPassword,
      keyboardType:
          widget.inputType == null ? TextInputType.text : widget.inputType,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w200,
        ),
        labelText: widget.labelText,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
