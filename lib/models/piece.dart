import 'package:flutter/material.dart';

class Piece {
  Piece(
      {required this.id,
      required this.position,
      required this.button,
      required this.insideHomeArea,
      required this.insideHome,
      required this.freedFromPrison});

  //color-num like red-1
  final String id;

  String position;
  ElevatedButton button;

// inside home area of blue is 1 to 7
// inside home area of yellow is 14 to 20
// inside home area for green is 27 to 33
// inside home area for red is to 40 to 46
  bool insideHomeArea;

  bool insideHome;

  bool freedFromPrison;
}
