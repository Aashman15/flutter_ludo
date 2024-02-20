import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ludo/models/piece.dart';
import 'package:ludo/data/pieces.dart';

class PiecesProvider extends StateNotifier<List<Piece>> {
  PiecesProvider() : super(pieces);

  void setPieces(List<Piece> pieces) {
    state = pieces;
  }
}

final piecesProvider = StateNotifierProvider<PiecesProvider, List<Piece>>(
  (ref) => PiecesProvider(),
);
