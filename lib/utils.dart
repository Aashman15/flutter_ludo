import 'package:ludo/clicked_piece.dart';
import 'package:ludo/dice_state.dart';
import 'package:ludo/models/piece.dart';
import 'package:ludo/pieces.dart';
import 'package:ludo/states/number_of_pieces.dart';

bool get shouldMove {
  String roller = diceState.rolledBy;
  int roll = diceState.roll;

  if (clickedPiece.isNotEmpty && !clickedPiece.contains(roller)) {
    return false;
  }

  List<Piece> filteredPieces =
      pieces.where((p) => p.id.contains(roller)).toList();

  List<Piece> unFreedPieces =
      filteredPieces.where((p) => !p.freedFromPrison).toList();

  if (roll == 1 && unFreedPieces.length == numberOfPiecesToBePlayed) {
    return true;
  }

  List<Piece> piecesNotInsideHome =
      filteredPieces.where((p) => !p.insideHome).toList();

  List<int> numberPositionsOnly = piecesNotInsideHome
      .where((p) => !p.position.contains('-') && p.position.isNotEmpty)
      .map((p) => int.parse(p.position))
      .toList();

  if (numberPositionsOnly.isNotEmpty) {
    return true;
  }

  List<String> aboutToEnterHomePositionsOnly = piecesNotInsideHome
      .where((p) => p.position.contains('-') && p.position.isNotEmpty)
      .map((p) => p.position)
      .toList();

  bool shouldMove = false;
  for (String position in aboutToEnterHomePositionsOnly) {
    List<String> splitted = position.split('-');
    if (int.parse(splitted[1]) + roll <= 6) {
      shouldMove = true;
      break;
    }
  }

  return shouldMove;
}

String getNextRoller(String roller, int roll) {
  if (roll == 6 || roll == 1) {
    return roller;
  }
  switch (roller) {
    case 'blue':
      return 'yellow';
    case 'yellow':
      return 'green';
    case 'green':
      return 'red';
    case 'red':
      return 'blue';
    default:
      throw Exception('invalid color');
  }
}

bool shouldGiveTurnToTheRoller(String roller) {
  List<Piece> piecesInsideHome = pieces
      .where((piece) => piece.id.contains(roller) && piece.insideHome)
      .toList();

  return piecesInsideHome.length != 4;
}
