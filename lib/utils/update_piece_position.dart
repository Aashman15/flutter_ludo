import 'package:ludo/models/piece.dart';
import 'package:ludo/data/pieces.dart';
import 'package:ludo/utils/sound_utils.dart';

void updatePiecePosition(String pieceId, int add, List<int> safePositions) {
  List<String> splittedPieceId = pieceId.split('-');

  for (int i = 0; i < pieces.length; i++) {
    if (pieces[i].id == pieceId) {
      try {
        String currentPosition = pieces[i].position;

        // handle color specific cases
        if (splittedPieceId[0] == 'blue') {
          if (!currentPosition.contains('-')) {
            int nextPosition = int.parse(currentPosition) + add;
            if (nextPosition > 52) {
              nextPosition = nextPosition - 52;
            }

            if (nextPosition >= 1 && nextPosition <= 7) {
              pieces[i].insideHomeArea = true;
            }

            if (nextPosition > 7 && pieces[i].insideHomeArea) {
              int difference = nextPosition - 7;
              pieces[i].position = 'b-$difference';
            } else {
              pieces[i].position = nextPosition.toString();
            }
          } else {
            List<String> splitted = currentPosition.split('-');
            int currentNum = int.parse(splitted[1]);
            int leftToReachHome = 6 - currentNum;

            if (add <= leftToReachHome) {
              int nextPosition = currentNum + add;

              if (nextPosition > 5) {
                pieces[i].insideHome = true;
                pieces[i].position = 'b-$nextPosition';
              } else {
                pieces[i].position = 'b-$nextPosition';
              }
            }
          }
        }

        if (splittedPieceId[0] == 'yellow') {
          if (!currentPosition.contains('-')) {
            int nextPosition = int.parse(currentPosition) + add;
            if (nextPosition > 52) {
              nextPosition = nextPosition - 52;
            }
            if (nextPosition >= 14 && nextPosition <= 20) {
              pieces[i].insideHomeArea = true;
            }
            if (nextPosition > 20 && pieces[i].insideHomeArea) {
              int difference = nextPosition - 20;
              pieces[i].position = 'y-$difference';
            } else {
              pieces[i].position = nextPosition.toString();
            }
          } else {
            List<String> splitted = currentPosition.split('-');
            int currentNum = int.parse(splitted[1]);
            int leftToReachHome = 6 - currentNum;

            if (add <= leftToReachHome) {
              int nextPosition = currentNum + add;

              if (nextPosition > 5) {
                pieces[i].insideHome = true;
                pieces[i].position = 'y-$nextPosition';
              } else {
                pieces[i].position = 'y-$nextPosition';
              }
            }
          }
        }

        if (splittedPieceId[0] == 'green') {
          if (!currentPosition.contains('-')) {
            int nextPosition = int.parse(currentPosition) + add;
            if (nextPosition > 52) {
              nextPosition = nextPosition - 52;
            }
            if (nextPosition >= 27 && nextPosition <= 33) {
              pieces[i].insideHomeArea = true;
            }
            if (nextPosition > 33 && pieces[i].insideHomeArea) {
              int difference = nextPosition - 33;
              pieces[i].position = 'g-$difference';
            } else {
              pieces[i].position = nextPosition.toString();
            }
          } else {
            List<String> splitted = currentPosition.split('-');
            int currentNum = int.parse(splitted[1]);
            int leftToReachHome = 6 - currentNum;

            if (add <= leftToReachHome) {
              int nextPosition = currentNum + add;

              if (nextPosition > 5) {
                pieces[i].insideHome = true;
                pieces[i].position = 'g-$nextPosition';
              } else {
                pieces[i].position = 'g-$nextPosition';
              }
            }
          }
        }

        if (splittedPieceId[0] == 'red') {
          if (!currentPosition.contains('-')) {
            int nextPosition = int.parse(currentPosition) + add;
            if (nextPosition > 52) {
              nextPosition = nextPosition - 52;
            }
            if (nextPosition >= 40 && nextPosition <= 46) {
              pieces[i].insideHomeArea = true;
            }
            if (nextPosition > 46 && pieces[i].insideHomeArea) {
              int difference = nextPosition - 46;
              pieces[i].position = 'r-$difference';
            } else {
              pieces[i].position = nextPosition.toString();
            }
          } else {
            List<String> splitted = currentPosition.split('-');
            int currentNum = int.parse(splitted[1]);
            int leftToReachHome = 6 - currentNum;

            if (add <= leftToReachHome) {
              int nextPosition = currentNum + add;

              if (nextPosition > 5) {
                pieces[i].insideHome = true;
                pieces[i].position = 'r-$nextPosition';
              } else {
                pieces[i].position = 'r-$nextPosition';
              }
            }
          }
        }
      } catch (e) {
        playSound('error');
      }

      // kill pieces
      if (!pieces[i].position.contains('-')) {
        if (!safePositions.contains(int.parse(pieces[i].position))) {
          List<Piece> piecesToBeKilled = pieces
              .where(
                (p) =>
                    p.position == pieces[i].position &&
                    !p.id.contains(pieceId.split('-')[0]),
              )
              .toList();
          if (piecesToBeKilled.isEmpty) {
            playSound('move');
          } else {
            playSound('kill');
          }
          for (int j = 0; j < pieces.length; j++) {
            if (piecesToBeKilled
                .where((p) => p.id == pieces[j].id)
                .isNotEmpty) {
              pieces[j].freedFromPrison = false;
              pieces[j].insideHome = false;
              pieces[j].insideHomeArea = false;
              pieces[j].position = '';
            }
          }
        } else {
          playSound('move');
        }
      } else {
        playSound('move');
      }
      // kill pieces ends here

      break;
    }
  }
}
