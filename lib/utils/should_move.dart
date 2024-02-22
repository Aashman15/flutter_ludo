import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ludo/models/board_initial_state.dart';
import 'package:ludo/models/piece.dart';
import 'package:ludo/providers/board_initial_state_provider.dart';
import 'package:ludo/providers/clicked_piece_provider.dart';
import 'package:ludo/providers/dice_state_provider.dart';
import 'package:ludo/providers/pieces_provider.dart';

bool shouldMove(WidgetRef ref) {
  final diceState = ref.watch(diceStateProvider);
  final pieces = ref.watch(piecesProvider);
  final boardInitialState = ref.watch(boardInitialStateProvider);

  String roller = diceState.rolledBy;
  int roll = diceState.roll;

  if (wrongPieceClicked(roller, ref)) {
    return false;
  }

  List<Piece> piecesOfRoller = getPiecesOfRoller(pieces, roller);

  if (gotOneButPiecesLeftInPrison(piecesOfRoller, boardInitialState, roll)) {
    return true;
  }

  List<Piece> piecesNotInsideHome =
      piecesOfRoller.where((p) => !p.insideHome).toList();

  if (piecesNotAboutToEnterHomeExists(piecesNotInsideHome)) {
    return true;
  }

  return shouldUpdatePositionForPiecesAboutToEnterHome(
      piecesNotInsideHome, roll);
}

bool shouldUpdatePositionForPiecesAboutToEnterHome(
    List<Piece> pieces, int roll) {
  List<String> aboutToEnterHomePositionsOnly = pieces
      .where((p) => p.position.contains('-'))
      .map((p) => p.position)
      .toList();

  bool shouldUpdate = false;
  for (String position in aboutToEnterHomePositionsOnly) {
    if (int.parse(position.split('-')[1]) + roll <= 6) {
      shouldUpdate = true;
      break;
    }
  }
  return shouldUpdate;
}

bool piecesNotAboutToEnterHomeExists(List<Piece> pieces) {
  List<int> positions = pieces
      .where((p) => !p.position.contains('-') && p.position.isNotEmpty)
      .map((p) => int.parse(p.position))
      .toList();

  return positions.isNotEmpty;
}

bool wrongPieceClicked(String roller, WidgetRef ref) {
  String clickedPiece = ref.watch(clickedPieceProvider);
  return clickedPiece.isNotEmpty && !clickedPiece.contains(roller);
}

List<Piece> getPiecesOfRoller(List<Piece> pieces, String roller) {
  return pieces.where((p) => p.id.contains(roller)).toList();
}

bool gotOneButPiecesLeftInPrison(
  List<Piece> pieces,
  BoardInitialState boardInitialState,
  int roll,
) {
  List<Piece> unFreedPieces = pieces.where((p) => !p.freedFromPrison).toList();
  return roll == 1 && unFreedPieces.isNotEmpty;
}
