import 'package:fitcards/utilities/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatefulWidget {
  final String buttonText;
  final Function onPressed;
  final Color textColor;
  final bool isOutline;
  final bool isRequest;
  final Color buttonColor;

  const CustomButton(
      {Key? key,
      required this.buttonText,
      required this.onPressed,
      required this.textColor,
      required this.isOutline,
      this.isRequest = false,
      required this.buttonColor})
      : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  TextStyle _textStyle() {
    return TextStyle(
        color: widget.textColor,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.bold,
        fontSize: 24,
        letterSpacing: 1);
  }

  Text _buttonText() {
    return Text(
      widget.buttonText.toUpperCase(),
      style: _textStyle(),
    );
  }

  RoundedRectangleBorder _shape() {
    return RoundedRectangleBorder(
      borderRadius: new BorderRadius.circular(8),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: Utils.buttonWidth(context),
      height: 50,
      child: widget.isOutline ? _buildOutlineButton() : _buildRaisedButton(),
    );
  }

  Widget _buildRaisedButton() {
    return TextButton(
      onPressed: () => widget.onPressed(),
      child: widget.isRequest ? CircularProgressIndicator() : _buttonText(),
    );
  }

  Widget _buildOutlineButton() {
    return OutlinedButton(
      onPressed: () => widget.onPressed(),
      child: widget.isRequest ? CircularProgressIndicator() : _buttonText(),
    );
  }
}
