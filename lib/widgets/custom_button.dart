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
      {Key key,
      this.buttonText,
      this.onPressed,
      this.textColor,
      this.isOutline,
      this.isRequest = false,
      this.buttonColor})
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
    return RaisedButton(
      shape: _shape(),
      onPressed: widget.onPressed,
      color: widget.buttonColor,
      child: widget.isRequest ? CircularProgressIndicator() : _buttonText(),
    );
  }

  Widget _buildOutlineButton() {
    return OutlineButton(
      borderSide: BorderSide(
          color: Theme.of(Get.context).textTheme.bodyText1.color, width: 2),
      shape: _shape(),
      onPressed: widget.onPressed,
      color: widget.buttonColor,
      child: widget.isRequest ? CircularProgressIndicator() : _buttonText(),
    );
  }
}
