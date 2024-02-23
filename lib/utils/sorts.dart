import 'package:ludo/models/piece.dart';
import 'package:ludo/utils/piece_util.dart';

void sortPiecesOfColor(List<Piece> pieces, String color) {
  if(getPiecesExceptColor(pieces, color).isNotEmpty){
    return;
  }

  pieces.sort((piece1, piece2) {
    int a = int.parse(piece1.id.split('-').last);
    int b = int.parse(piece2.id.split('-').last);
    return a.compareTo(b);
  });
}
