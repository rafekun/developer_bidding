import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton(
      {@required this.buttonText,
        @required this.buttonColor,
        @required this.buttonPressed,
        this.buttonTextColors});

  final Color buttonColor;
  final Function buttonPressed;
  final String buttonText;
  final Color buttonTextColors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: buttonColor,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: buttonPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            buttonText,
            style: TextStyle(color: buttonTextColors),
          ),
        ),
      ),
    );
  }
}
