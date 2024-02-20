import 'package:flutter/material.dart';
import 'package:ludo/models/piece.dart';
import 'package:ludo/data/pieces.dart';
import 'package:ludo/screens/board/widgets/piece_button.dart';

// if position matches then return piece id
// if more than one piece found with same position then return piece id of active color
String getPieceId(String position, String activeColor) {
  List<Piece> filteredPieces =
      pieces.where((piece) => piece.position == position).toList();

  // length of pieces at same postion
  int length = filteredPieces.length;

  if (length == 1) {
    return filteredPieces[0].id;
  }

  if (length > 1) {
    List<Piece> activeColorPieces = filteredPieces
        .where(
          (piece) => piece.id.contains(activeColor),
        )
        .toList();
    if (activeColorPieces.isNotEmpty) return activeColorPieces.first.id;
  }

  return '';
}

// if position matches then return button adding onPressed method
// if more than one piece with same position found then return button with active color adding onPressed method
Widget getTableCellChild(
    String position, String activeColor, void Function() onPieceClick) {
  List<Piece> filteredPieces =
      pieces.where((piece) => piece.position == position).toList();

// length of pieces at same postion
  int length = filteredPieces.length;

  if (length == 1) {
    PieceButton originalButton = filteredPieces[0].button;

    return SizedBox(
      height: 20,
      width: 20,
      child: PieceButton(
        backgroundColor: originalButton.backgroundColor,
        onPressed: onPieceClick,
      ),
    );
  }

  if (length > 1) {
    List<Piece> piecesWithActiveColor = filteredPieces
        .where(
          (piece) => piece.id.contains(activeColor),
        )
        .toList();

    PieceButton originalButton;
    if (piecesWithActiveColor.isNotEmpty) {
      originalButton = filteredPieces
          .where(
            (piece) => piece.id.contains(activeColor),
          )
          .toList()
          .first
          .button;
    } else {
      originalButton = filteredPieces[0].button;
    }

    return SizedBox(
      height: 20,
      width: 20,
      child: PieceButton(
        backgroundColor: originalButton.backgroundColor,
        onPressed: onPieceClick,
      ),
    );
  }

  return const Text('');
}
