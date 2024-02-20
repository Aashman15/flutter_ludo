import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClickedPieceProvider extends StateNotifier<String> {
  ClickedPieceProvider() : super('');

  void setClickedPiece(String pieceId) {
    state = pieceId;
  }
}

final clickedPieceProvider =
    StateNotifierProvider<ClickedPieceProvider, String>(
  (ref) => ClickedPieceProvider(),
);
