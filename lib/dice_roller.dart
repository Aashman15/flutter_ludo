import 'package:flutter/material.dart';
import 'package:ludo/clicked_piece.dart';
import 'dart:math';

import 'package:ludo/dice_state.dart';
import 'package:ludo/models/piece.dart';
import 'package:ludo/moved_rolled.dart';
import 'package:ludo/pieces.dart';
import 'package:ludo/should_move.dart';
import 'package:ludo/utils/sound_utils.dart';

final randomizer = Random();

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key, required this.onDiceRoll, required this.color});

  final void Function() onDiceRoll;
  final String color;

  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

class _DiceRollerState extends State<DiceRoller> {
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

  void rollDice() {
    setState(() {
      clickedPiece = '';
      if (shouldMove && !moved) {
        playSound('error');
        return;
      }
      moved = false;
      rolled = true;

      diceState.previousRoll = diceState.roll;
      diceState.previousRoller = diceState.rolledBy;

      int currentRoll = randomizer.nextInt(6) + 1;
      diceState.roll = currentRoll;

      String currentRoller = '';
      if (!diceState.rolled) {
        diceState.rolled = true;
        diceState.rolledBy = 'blue';
        currentRoller = 'blue';
      } else {
        if (diceState.previousRoll == 1 || diceState.previousRoll == 6) {
          diceState.rolledBy = diceState.previousRoller;
        } else {
          diceState.rolledBy =
              getNextRoller(diceState.previousRoller, diceState.previousRoll);
        }
        currentRoller = diceState.rolledBy;
      }

      diceState.nextRoller = getNextRoller(currentRoller, currentRoll);
      playSound('roll');

      widget.onDiceRoll();
    });
  }

  @override
  Widget build(context) {
    int currentDiceRoll = diceState.roll == 0 ? 1 : diceState.roll;
    String currentColor = widget.color.toLowerCase();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: rollDice,
          child: Image.asset(
            'assets/images/dice-$currentColor-$currentDiceRoll.png',
            width: 50,
            height: 50,
          ),
        ),
      ],
    );
  }
}
