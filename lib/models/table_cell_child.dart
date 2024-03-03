import 'package:flutter/material.dart';

class TableCellChild {
  const TableCellChild(
      {this.pieceId, required this.isPieceButton, required this.child});

  final String? pieceId;
  final bool isPieceButton;
  final Widget child;
}
