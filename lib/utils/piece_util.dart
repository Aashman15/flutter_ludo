import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ludo/models/piece.dart';
import 'package:ludo/providers/pieces_provider.dart';

List<Piece> getPiecesOfColor(List<Piece> pieces, String color) {
  return pieces.where((p) => p.id.contains(color)).toList();
}

List<Piece> getPiecesExceptColor(List<Piece> pieces, String color) {
  return pieces.where((p) => !p.id.contains(color)).toList();
}

Piece getPiece(String pieceId, WidgetRef ref) {
  final allPieces = ref.watch(piecesProvider);

  return allPieces.where((piece) => piece.id == pieceId).first;
}
