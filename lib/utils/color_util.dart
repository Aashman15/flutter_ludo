import 'package:flutter/material.dart';

const myColors = [
  MyColors.blue,
  MyColors.yellow,
  MyColors.green,
  MyColors.red,
];

const colorsOrder = {
  MyColors.blue: 0,
  MyColors.yellow: 1,
  MyColors.green: 2,
  MyColors.red: 3,
};

const aboutToEnterHomePositionColors = {
  MyColors.blue: Color.fromARGB(80, 33, 150, 243),
  MyColors.yellow: Color.fromARGB(80, 255, 235, 59),
  MyColors.green: Color.fromARGB(80, 76, 175, 80),
  MyColors.red: Color.fromARGB(80, 244, 67, 54),
};

Color? getAboutToEnterHomePositionColor(String color) {
  return aboutToEnterHomePositionColors[color];
}

class MyColors {
  static const blue = 'blue';
  static const yellow = 'yellow';
  static const green = 'green';
  static const red = 'red';
}
