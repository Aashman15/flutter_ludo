import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ludo/models/piece.dart';
import 'package:ludo/models/table_cell_child.dart';
import 'package:ludo/providers/pieces_provider.dart';
import 'package:ludo/screens/board/widgets/piece_button.dart';

// if position matches then return piece id
// if more than one piece found with same position then return piece id of active color
String getPieceId(String position, String activeColor, WidgetRef ref) {
  List<Piece> pieces = ref.watch(piecesProvider);

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
TableCellChild getTableCellChild(String position, String activeColor,
    void Function() onPieceClick, WidgetRef ref) {
  List<Piece> pieces = ref.watch(piecesProvider);

  List<Piece> filteredPieces =
      pieces.where((piece) => piece.position == position).toList();

// length of pieces at same postion
  int length = filteredPieces.length;

  if (length == 1) {
    PieceButton originalButton = filteredPieces[0].button;

    return TableCellChild(
      pieceId: filteredPieces[0].id,
      isPieceButton: true,
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

    Piece piece;
    if (piecesWithActiveColor.isNotEmpty) {
      piece = filteredPieces
          .where(
            (piece) => piece.id.contains(activeColor),
          )
          .toList()
          .first;
    } else {
      piece = filteredPieces[0];
    }

    return TableCellChild(
      pieceId: piece.id,
      isPieceButton: true,
      child: PieceButton(
        backgroundColor: piece.button.backgroundColor,
        onPressed: onPieceClick,
      ),
    );
  }

  return const TableCellChild(isPieceButton: false, child: Text(''));
}
