import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ludo/models/piece.dart';
import 'package:ludo/data/pieces.dart';

class PiecesProvider extends StateNotifier<List<Piece>> {
  PiecesProvider() : super(pieces);

  void setPieces(List<Piece> pieces) {
    state = pieces;
  }

  void replaceProvidedPiecesOnly(List<Piece> pieces) {
    List<Piece> allPieces = state;

    List<String> listOfPieceId = pieces.map((piece) => piece.id).toList();

    List<Piece> updatedPieces =
        allPieces.where((piece) => !listOfPieceId.contains(piece.id)).toList();

    state = [...updatedPieces, ...pieces];
  }
}

final piecesProvider = StateNotifierProvider<PiecesProvider, List<Piece>>(
  (ref) => PiecesProvider(),
);
