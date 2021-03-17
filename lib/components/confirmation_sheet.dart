import 'package:flutter/material.dart';
import 'package:ride_share_driver/components/rounded_button.dart';
import 'package:ride_share_driver/constants.dart';

import 'RoundedOutlineButton.dart';

class ConfirmationSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 15.0,
          spreadRadius: 0.5,
          offset: Offset(0.7, 0.7),
        ),
      ]),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
        child: Column(
          children: [
            Text(
              'GO ONLINE',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22.0,
                fontFamily: BoldFont,
                color: colorText,
              ),
            ),
            SizedBox(height: 24.0),
            Text(
              'You are about to go become available to receive trip requests.',
              textAlign: TextAlign.center,
              style: TextStyle(color: colorTextLight),
            ),
            SizedBox(height: 24.0),
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: RoundedOutlineButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: colorLightGrayFair,
                      title: 'BACK',
                    ),
                  ),
                ),
                SizedBox(width: 15.0),
                Expanded(
                  child: Container(
                    child: RoundedButton(
                      onPressed: () {},
                      width: 135,
                      height: 50,
                      fillColor: colorGreen,
                      title: 'CONFIRM',
                      titleColor: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
