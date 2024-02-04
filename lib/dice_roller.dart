import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ludo/clicked_piece.dart';
import 'package:ludo/dice_state.dart';
import 'package:ludo/moved_rolled.dart';
import 'package:ludo/utils.dart';
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

      if (diceState.previousRoll == 1 || diceState.previousRoll == 6) {
        diceState.rolledBy = diceState.previousRoller;
      } else {
        String nextRoller =
            getNextRoller(diceState.previousRoller, diceState.previousRoll);

        bool keepLooping = true;
        while (keepLooping) {
          if (!shouldGiveTurnToTheRoller(nextRoller)) {
            nextRoller = getNextRoller(nextRoller, 0);
          } else {
            keepLooping = false;
          }
        }

        diceState.rolledBy = nextRoller;
      }

      diceState.nextRoller = getNextRoller(diceState.rolledBy, currentRoll);
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
