import 'package:flutter/material.dart';
import 'package:ludo/areas/blue_area.dart';
import 'package:ludo/clicked_piece.dart';
import 'package:ludo/dice_roller.dart';
import 'package:ludo/dice_state.dart';
import 'package:ludo/areas/green_area.dart';
import 'package:ludo/models/piece.dart';
import 'package:ludo/moved_rolled.dart';
import 'package:ludo/pieces.dart';
import 'package:ludo/prison.dart';
import 'package:ludo/areas/red_area.dart';
import 'package:ludo/safe_zones.dart';
import 'package:ludo/should_move.dart';
import 'package:ludo/areas/yellow_area.dart';
import 'package:ludo/utils/sound_utils.dart';

class LudoBoardV2 extends StatefulWidget {
  const LudoBoardV2({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LudoBoardV2State();
  }
}

class _LudoBoardV2State extends State<LudoBoardV2> {
  void updatePiecePosition(String pieceId, int add) {
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
          if (!safeZones.contains(int.parse(pieces[i].position))) {
            List<Piece> piecesToBeKilled = pieces
                .where(
                  (p) =>
                      p.position == pieces[i].position &&
                      !p.id.contains(pieceId.split('-')[0]),
                )
                .toList();
            if(piecesToBeKilled.isEmpty){
              playSound('move');
            }else{
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
          }else{
            playSound('move');
          }
        }else{
          playSound('move');
        }
        // kill pieces ends here

        break;
      }
    }
  }

  void rollDice() {
    setState(() {
      print('hi');
    });
  }

  void onFreePiece() {
    setState(() {
      print('hi');
    });
  }

  void onPieceClick(String pieceId) {
    if (pieceId.isEmpty || !pieceId.contains(diceState.rolledBy)) {
      playSound('error');
      return;
    }

    String piecePosition =
        pieces.where((element) => element.id == pieceId).first.position;

    if (piecePosition.contains('-')) {
      List<String> split = piecePosition.split('-');
      if (int.parse(split[1]) + diceState.roll > 6) {
        playSound('error');
        return;
      }
    }

    clickedPiece = pieceId;
    setState(() {
      if (rolled) {
        updatePiecePosition(pieceId, diceState.roll);
      } else {
        playSound('error');
      }
      rolled = false;
      moved = true;
    });
  }

  String capitalizeFirstLetter(String word) {
    if (word.isEmpty) return word;
    return word[0].toUpperCase() + word.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    String message = '';

    if (!diceState.rolled) {
      message = 'Blue, please roll the dice!';
    } else {
      String roller = diceState.rolledBy;
      if (shouldMove && !moved && rolled) {
        message = capitalizeFirstLetter('$roller, please move your piece!');
      } else {
        roller = diceState.nextRoller;
        message = capitalizeFirstLetter('$roller, please roll the dice!');
      }
    }

   String diceColor =  message.split(',')[0];

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Prison(color: 'red', onFreePiece: onFreePiece),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                width: 100,
                child: BlueArea(onPieceClick: onPieceClick),
              ),
              const SizedBox(
                width: 20,
              ),
              Prison(color: 'blue', onFreePiece: onFreePiece)
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 150,
                child: RedArea(onPieceClick: onPieceClick),
              ),
              const SizedBox(
                width: 5,
              ),
              DiceRoller(onDiceRoll: rollDice, color: diceColor,),
              const SizedBox(
                width: 5,
              ),
              SizedBox(
                width: 150,
                child: YellowArea(onPieceClick: onPieceClick),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Prison(color: 'green', onFreePiece: onFreePiece),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                width: 100,
                child: GreenArea(onPieceClick: onPieceClick),
              ),
              const SizedBox(
                width: 20,
              ),
              Prison(color: 'yellow', onFreePiece: onFreePiece)
            ],
          )
        ],
      ),
    );
  }
}
