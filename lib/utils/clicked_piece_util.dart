import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ludo/providers/clicked_piece_provider.dart';

void updateClickedPiece(WidgetRef ref, String pieceId){
  ref.read(clickedPieceProvider.notifier).setClickedPiece(pieceId);
}

void resetClickedPiece(WidgetRef ref){
  ref.read(clickedPieceProvider.notifier).resetState();
}