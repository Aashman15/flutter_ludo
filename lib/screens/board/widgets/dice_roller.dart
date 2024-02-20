import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ludo/models/dice.state.dart';
import 'package:ludo/providers/board_initial_state_provider.dart';
import 'package:ludo/providers/dice_state_provider.dart';
import 'package:ludo/utils/should_move.dart';
import 'package:ludo/utils/sound_utils.dart';

final randomizer = Random();

class DiceRoller extends ConsumerWidget {
  const DiceRoller({super.key});

  void rollDice(WidgetRef ref, DiceState diceState) {
    if (!diceState.shouldRoll) {
      playSound('error');
      return;
    }

    int currentRoll = randomizer.nextInt(6) + 1;

    diceState.roll = currentRoll;
    diceState.rolledBy = diceState.nextRoller;

    if (currentRoll != 6 || currentRoll != 1) {
      diceState.nextRoller = getNextRoller(diceState.rolledBy, ref);
    }

    updateShouldRoll(ref);
  }

  void updateShouldRoll(WidgetRef ref) {
    final notifier = ref.read(diceStateProvider.notifier);

    if (shouldMove(ref)) {
      notifier.setShouldRoll(false);
    } else {
      notifier.setShouldRoll(true);
    }
  }

  String getNextRoller(String roller, WidgetRef ref) {
    final boardInitialState = ref.watch(initialStateProvider);

    final rollers = boardInitialState.selectedColors;

    int rollerIndex = rollers.indexOf(roller);

    // if roller is at the end of the list then return the first
    if (rollerIndex == rollers.length - 1) {
      return rollers[0];
    }

    return rollers[rollerIndex + 1];
  }

  @override
  Widget build(context, WidgetRef ref) {
    final diceState = ref.watch(diceStateProvider);
    final boardInitialState = ref.watch(initialStateProvider);

    var currentColor = diceState.nextRoller;
    var currentRoll = diceState.roll;

    if (currentColor.isEmpty) {
      currentColor = boardInitialState.firstTurn;
      currentRoll = 1;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            rollDice(ref, diceState);
          },
          child: Image.asset(
            'assets/images/dice-$currentColor-$currentRoll.png',
            width: 50,
            height: 50,
          ),
        ),
      ],
    );
  }
}