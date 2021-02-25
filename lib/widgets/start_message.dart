import 'package:flutter/material.dart';

Widget startText() {
  return (Container(
    padding: EdgeInsets.all(40),
    child: Text(
      'City isn\'t selected, please find location or use current location.',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 30),
    ),
  ));
}
