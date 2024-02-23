import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ludo/models/piece.dart';
import 'package:ludo/providers/dice_state_provider.dart';
import 'package:ludo/providers/pieces_provider.dart';
import 'package:ludo/providers/safe_zones_provider.dart';
import 'package:ludo/utils/color_util.dart';

const Map<String, List<int>> insideHomeAreaCriteria = {
  // [0] = min
  // [1] = max
  MyColors.blue: [1, 7],
  MyColors.yellow: [14, 20],
  MyColors.green: [27, 33],
  MyColors.red: [40, 46],
};

String updatePiecePosition(String pieceId, int roll, WidgetRef ref) {
  final pieces = ref.watch(piecesProvider);

  final piece = pieces.where((piece) => pieceId == piece.id).first;

  final position = piece.position;

  String color = pieceId.split('-')[0];

  String response = '';

  if (aboutToEnterHome(position)) {
    response =
        handleAboutToEnterHomePosition(roll, position, piece, color, ref);
  } else {
    response = handleOtherPosition(roll, position, piece, color, ref);
  }

  bool killed = killPieces(pieceId, ref);

  if (killed) {
    ref.read(diceStateProvider.notifier).setShouldRoll(true);
    ref.read(diceStateProvider.notifier).setNextRoller(color);
    response = 'movedAndKilled';
  }
  return response;
}

bool killPieces(String pieceId, WidgetRef ref) {
  List<int> safePositions = ref.watch(safePositionsProvider);
  List<Piece> pieces = ref.watch(piecesProvider);

  String position = pieces.where((piece) => piece.id == pieceId).first.position;

  bool killed = false;

  // used for not killing its friends determined by the same color
  final color = pieceId.split('-')[0];
  List<Piece> piecesToBeKilled = getPiecesForKilling(pieces, position, color);

  if (shouldKill(position, safePositions, piecesToBeKilled)) {
    for (int i = 0; i < piecesToBeKilled.length; i++) {
      piecesToBeKilled[i].freedFromPrison = false;
      piecesToBeKilled[i].insideHome = false;
      piecesToBeKilled[i].insideHomeArea = false;
      piecesToBeKilled[i].position = '';
    }

    ref
        .read(piecesProvider.notifier)
        .replaceProvidedPiecesOnly(piecesToBeKilled);

    killed = piecesToBeKilled.isNotEmpty;
  }
  return killed;
}

List<Piece> getPiecesForKilling(
    List<Piece> pieces, String position, String color) {
  return pieces
      .where(
        (p) =>
            p.position == position &&
            !p.id.contains(
              color,
            ),
      )
      .toList();
}

bool shouldKill(
    String position, List<int> safePositions, List<Piece> piecesToBeKilled) {
  return !aboutToEnterHome(position) &&
      !isSafePosition(position, safePositions) &&
      piecesToBeKilled.isNotEmpty;
}

bool aboutToEnterHome(String position) {
  return position.contains('-');
}

bool isSafePosition(String position, List<int> safePositions) {
  return safePositions.contains(int.parse(position));
}

String handleAboutToEnterHomePosition(
    int roll, String position, Piece piece, String color, WidgetRef ref) {
  List<String> splitted = position.split('-');
  int currentNum = int.parse(splitted[1]);
  int leftToReachHome = 6 - currentNum;

  String positionPrefix = color[0].toLowerCase();

  if (roll <= leftToReachHome) {
    int nextPosition = currentNum + roll;

    if (nextPosition > 5) {
      piece.insideHome = true;
      piece.position = '$positionPrefix-$nextPosition';
      ref.read(diceStateProvider.notifier).setShouldRoll(true);
      ref.read(diceStateProvider.notifier).setNextRoller(color);
      return 'enteredHome';
    } else {
      piece.position = '$positionPrefix-$nextPosition';
    }
    ref.read(piecesProvider.notifier).replaceProvidedPiecesOnly([piece]);
  }
  return 'justMoved';
}

String handleOtherPosition(
    int roll, String position, Piece piece, String color, WidgetRef ref) {
  if (!aboutToEnterHome(position)) {
    int nextPosition = int.parse(position) + roll;

    // as the greatest position any pieces can travel is 52 and if 52 is crossed then
    // position will start from 1 again depending upon roll

    if (nextPosition > 52) {
      nextPosition = nextPosition - 52;
    }

    if (enteredInsideHomeArea(color, nextPosition)) {
      piece.insideHomeArea = true;
    }

    if (willCrossMaxPosition(color, nextPosition) && piece.insideHomeArea) {
      int max = insideHomeAreaCriteria[color]!.last;

      int difference = nextPosition - max;

      final positionPrefix = color[0].toLowerCase();

      piece.position = '$positionPrefix-$difference';
    } else {
      piece.position = nextPosition.toString();
    }

    ref.read(piecesProvider.notifier).replaceProvidedPiecesOnly([piece]);
    if (piece.position.contains('-')) {
      if (int.parse(piece.position.split('-')[1]) >= 6) {
        piece.insideHome = true;
        return 'enteredHome';
      }
    }
    return 'justMoved';
  }
  return '';
}

bool willCrossMaxPosition(String color, int nextPosition) {
  final max = insideHomeAreaCriteria[color]!.last;
  return nextPosition > max;
}

bool enteredInsideHomeArea(String color, int nextPosition) {
  final min = insideHomeAreaCriteria[color]!.first;
  final max = insideHomeAreaCriteria[color]!.last;

  return nextPosition >= min && nextPosition <= max;
}
