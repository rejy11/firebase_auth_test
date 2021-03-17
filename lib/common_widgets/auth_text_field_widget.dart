import 'package:flutter/material.dart';

class AuthTextFieldWidget extends StatefulWidget {
  AuthTextFieldWidget({
    Key key,
    @required this.labelText,
    @required this.hintText,
    @required this.textEditingController,
    this.isPassword,
    this.inputType,
    this.suffix,
  }) : super(key: key);

  final String labelText;
  final String hintText;
  final TextEditingController textEditingController;
  final bool isPassword;
  final TextInputType inputType;
  final Icon suffix;

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
        suffixIcon: widget.suffix,        
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0.0,
            color: Colors.white54,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0.0,
            color: Theme.of(context).accentColor,
          ),
          borderRadius: BorderRadius.circular(20),
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
      cursorColor: Theme.of(context).accentColor,
    );
  }
}
