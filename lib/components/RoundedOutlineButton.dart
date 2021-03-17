import 'package:flutter/material.dart';

import '../constants.dart';

class RoundedOutlineButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final Color color;

  RoundedOutlineButton({this.title, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
        borderSide: BorderSide(color: color),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        onPressed: onPressed,
        color: color,
        textColor: color,
        child: Container(
          height: 50.0,
          width: 125,
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                fontFamily: 'Brand-Bold',
                color: colorText,
              ),
            ),
          ),
        ));
  }
}
