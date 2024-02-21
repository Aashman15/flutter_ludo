import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ludo/models/piece.dart';
import 'package:ludo/providers/pieces_provider.dart';
import 'package:ludo/providers/safe_zones_provider.dart';
import 'package:ludo/utils/sound_utils.dart';

void updatePiecePosition(String pieceId, int roll, WidgetRef ref) {
  List<Piece> piecesFromProvider = ref.watch(piecesProvider);
  List<int> safePositions = ref.watch(safePositionsProvider);

  List<Piece> pieces = [...piecesFromProvider];

  for (int i = 0; i < pieces.length; i++) {
    if (pieces[i].id == pieceId) {
      Piece piece = pieces[i];

      updatePositionIfColorIsBlue(roll, piece);

      updatePositionIfColorIsYellow(roll, piece);

      updatePositionIfColorIsGreen(roll, piece);

      updatePositionIfColorIsRed(roll, piece);

      bool killed = killPieces(pieces[i], safePositions, pieces);

      if (killed) {
        playSound('kill');
      } else {
        playSound('move');
      }

      break;
    }
  }

  ref.read(piecesProvider.notifier).setPieces(pieces);
}

bool killPieces(Piece piece, List<int> safePositions, List<Piece> pieces) {
  String position = piece.position;
  String pieceId = piece.id;

  bool killed = false;
  if (!position.contains('-') && !safePositions.contains(int.parse(position))) {
    List<Piece> piecesToBeKilled = pieces
        .where(
          (p) =>
              p.position == position &&
              !p.id.contains(
                pieceId.split('-')[0],
              ),
        )
        .toList();

    for (int i = 0; i < piecesToBeKilled.length; i++) {
      piecesToBeKilled[i].freedFromPrison = false;
      piecesToBeKilled[i].insideHome = false;
      piecesToBeKilled[i].insideHomeArea = false;
      piecesToBeKilled[i].position = '';
    }

    if (piecesToBeKilled.isNotEmpty) {
      killed = true;
    }
  }
  return killed;
}

void updatePositionIfColorIsRed(int add, Piece piece) {
  String currentPosition = piece.position;
  final color = piece.id.split('-')[0];
  if (color == 'red') {
    if (!currentPosition.contains('-')) {
      int nextPosition = int.parse(currentPosition) + add;
      if (nextPosition > 52) {
        nextPosition = nextPosition - 52;
      }
      if (nextPosition >= 40 && nextPosition <= 46) {
        piece.insideHomeArea = true;
      }
      if (nextPosition > 46 && piece.insideHomeArea) {
        int difference = nextPosition - 46;
        piece.position = 'r-$difference';
      } else {
        piece.position = nextPosition.toString();
      }
    } else {
      List<String> splitted = currentPosition.split('-');
      int currentNum = int.parse(splitted[1]);
      int leftToReachHome = 6 - currentNum;

      if (add <= leftToReachHome) {
        int nextPosition = currentNum + add;

        if (nextPosition > 5) {
          piece.insideHome = true;
          piece.position = 'r-$nextPosition';
        } else {
          piece.position = 'r-$nextPosition';
        }
      }
    }
  }
}

void updatePositionIfColorIsGreen(int add, Piece piece) {
  String currentPosition = piece.position;
  final color = piece.id.split('-')[0];
  if (color == 'green') {
    if (!currentPosition.contains('-')) {
      int nextPosition = int.parse(currentPosition) + add;
      if (nextPosition > 52) {
        nextPosition = nextPosition - 52;
      }
      if (nextPosition >= 27 && nextPosition <= 33) {
        piece.insideHomeArea = true;
      }
      if (nextPosition > 33 && piece.insideHomeArea) {
        int difference = nextPosition - 33;
        piece.position = 'g-$difference';
      } else {
        piece.position = nextPosition.toString();
      }
    } else {
      List<String> splitted = currentPosition.split('-');
      int currentNum = int.parse(splitted[1]);
      int leftToReachHome = 6 - currentNum;

      if (add <= leftToReachHome) {
        int nextPosition = currentNum + add;

        if (nextPosition > 5) {
          piece.insideHome = true;
          piece.position = 'g-$nextPosition';
        } else {
          piece.position = 'g-$nextPosition';
        }
      }
    }
  }
}

void updatePositionIfColorIsYellow(int add, Piece piece) {
  String currentPosition = piece.position;
  final color = piece.id.split('-')[0];

  if (color == 'yellow') {
    if (!currentPosition.contains('-')) {
      int nextPosition = int.parse(currentPosition) + add;
      if (nextPosition > 52) {
        nextPosition = nextPosition - 52;
      }
      if (nextPosition >= 14 && nextPosition <= 20) {
        piece.insideHomeArea = true;
      }
      if (nextPosition > 20 && piece.insideHomeArea) {
        int difference = nextPosition - 20;
        piece.position = 'y-$difference';
      } else {
        piece.position = nextPosition.toString();
      }
    } else {
      List<String> splitted = currentPosition.split('-');
      int currentNum = int.parse(splitted[1]);
      int leftToReachHome = 6 - currentNum;

      if (add <= leftToReachHome) {
        int nextPosition = currentNum + add;

        if (nextPosition > 5) {
          piece.insideHome = true;
          piece.position = 'y-$nextPosition';
        } else {
          piece.position = 'y-$nextPosition';
        }
      }
    }
  }
}

void updatePositionIfColorIsBlue(int add, Piece piece) {
  final currentPosition = piece.position;
  final color = piece.id.split('-')[0];

  if (color == 'blue') {
    if (!currentPosition.contains('-')) {
      int nextPosition = int.parse(currentPosition) + add;
      if (nextPosition > 52) {
        nextPosition = nextPosition - 52;
      }

      if (nextPosition >= 1 && nextPosition <= 7) {
        piece.insideHomeArea = true;
      }

      if (nextPosition > 7 && piece.insideHomeArea) {
        int difference = nextPosition - 7;
        piece.position = 'b-$difference';
      } else {
        piece.position = nextPosition.toString();
      }
    } else {
      List<String> splitted = currentPosition.split('-');
      int currentNum = int.parse(splitted[1]);
      int leftToReachHome = 6 - currentNum;

      if (add <= leftToReachHome) {
        int nextPosition = currentNum + add;

        if (nextPosition > 5) {
          piece.insideHome = true;
          piece.position = 'b-$nextPosition';
        } else {
          piece.position = 'b-$nextPosition';
        }
      }
    }
  }
}
