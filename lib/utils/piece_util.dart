import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ludo/models/board_initial_state.dart';
import 'package:ludo/models/piece.dart';
import 'package:ludo/providers/board_initial_state_provider.dart';
import 'package:ludo/providers/pieces_provider.dart';

List<Piece> getPiecesOfColor(List<Piece> pieces, String color) {
  return pieces.where((p) => p.id.contains(color)).toList();
}

List<Piece> getPiecesExceptColor(List<Piece> pieces, String color) {
  return pieces.where((p) => !p.id.contains(color)).toList();
}

Piece getPiece(String pieceId, WidgetRef ref) {
  final allPieces = ref.watch(piecesProvider);

  return allPieces
      .where((piece) => piece.id == pieceId)
      .first;
}

void updatePiecesAccordingToBoardInitialState(WidgetRef ref) {
  final pieces = ref.watch(piecesProvider);
  final boardInitialState = ref.watch(boardInitialStateProvider);

  final filteredPieces = _getPiecesAccordingToBoardInitialState(pieces, boardInitialState);

  ref.read(piecesProvider.notifier).setPieces(filteredPieces);
}

List<Piece> _getPiecesAccordingToBoardInitialState(List<Piece> pieces, BoardInitialState boardInitialState) {
  return pieces.where((piece) {
    String color = getPieceColor(piece);
    int pieceNumber = getPieceNumber(piece);

    return boardInitialState.selectedColors.contains(color) &&
        pieceNumber <= boardInitialState.numberOfPieces;
  }).toList();
}

String getPieceColor(Piece piece) {
  return piece.id
      .split('-')
      .first;
}

int getPieceNumber(Piece piece) {
  return int.parse(piece.id
      .split('-')
      .last);
}
