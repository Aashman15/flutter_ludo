import 'package:flutter/material.dart';

List<String> colors = ['blue', 'yellow', 'green', 'red'];

String getColorName(Color color) {
  final Map<Color, String> colorNames = {
    Colors.red: 'red',
    Colors.blue: 'blue',
    Colors.yellow: 'yellow',
    Colors.green: 'green'
  };

  String? name = colorNames[color];
  return name ?? 'Unknown';
}

Color? getColor(String colorName) {
  final Map<String, Color> colors = {
    'red': Colors.red,
    'blue': Colors.blue,
    'yellow': Colors.yellow,
    'green': Colors.green,
  };

  return colors[colorName];
}
