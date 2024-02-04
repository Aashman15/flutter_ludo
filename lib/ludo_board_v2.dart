import 'package:flutter/material.dart';
import 'package:ludo/areas/blue_area.dart';
import 'package:ludo/clicked_piece.dart';
import 'package:ludo/congrats_dialog.dart';
import 'package:ludo/dice_roller.dart';
import 'package:ludo/dice_state.dart';
import 'package:ludo/areas/green_area.dart';
import 'package:ludo/models/piece.dart';
import 'package:ludo/moved_rolled.dart';
import 'package:ludo/pieces.dart';
import 'package:ludo/prison.dart';
import 'package:ludo/areas/red_area.dart';
import 'package:ludo/safe_zones.dart';
import 'package:ludo/utils.dart';
import 'package:ludo/areas/yellow_area.dart';
import 'package:ludo/states/first_roller.dart';
import 'package:ludo/utils/sound_utils.dart';
import 'package:ludo/utils/update_piece_position.dart';

class LudoBoardV2 extends StatefulWidget {
  const LudoBoardV2({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LudoBoardV2State();
  }
}

class _LudoBoardV2State extends State<LudoBoardV2> {
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
        if (pieces
                .where((element) =>
                    element.id.contains(diceState.rolledBy) &&
                    element.insideHome)
                .length ==
            4) {
          congratsDialog(context);
        }
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
      diceState.rolled = true;
      diceState.roll = 1;
      diceState.rolledBy = firstEverRoller;
      diceState.nextRoller = firstEverRoller;
      message =
          capitalizeFirstLetter('$firstEverRoller, please roll the dice!');
    } else {
      String roller = diceState.rolledBy;
      if (shouldMove && !moved && rolled) {
        message = capitalizeFirstLetter('$roller, please move your piece!');
      } else {
        roller = diceState.nextRoller;

        bool keepLooping = true;
        while (keepLooping) {
          if (!shouldGiveTurnToTheRoller(roller)) {
            diceState.previousRoller = roller;
            diceState.previousRoll = 0;
            roller =
                getNextRoller(diceState.previousRoller, diceState.previousRoll);
          } else {
            keepLooping = false;
          }
        }

        message = capitalizeFirstLetter('$roller, please roll the dice!');
      }
    }

    String diceColor = message.split(',')[0];

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
              DiceRoller(
                onDiceRoll: rollDice,
                color: diceColor,
              ),
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
