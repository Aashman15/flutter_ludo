import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ludo/models/piece.dart';
import 'package:ludo/providers/board_initial_state_provider.dart';
import 'package:ludo/providers/dice_state_provider.dart';
import 'package:ludo/providers/pieces_provider.dart';
import 'package:ludo/utils/clicked_piece_util.dart';
import 'package:ludo/utils/dice_state_util.dart';
import 'package:ludo/utils/sound_utils.dart';

final randomizer = Random();

class DiceRoller extends ConsumerWidget {
  const DiceRoller({super.key});

  void rollDice(WidgetRef ref) {
    final diceState = ref.watch(diceStateProvider);
    final newDiceState = getCopyOfDiceState(diceState);

    if (!newDiceState.shouldRoll) {
      playSound(MySounds.error);
      return;
    }

    resetClickedPiece(ref);

    int currentRoll = randomizer.nextInt(6) + 1;

    newDiceState.roll = currentRoll;

    if (isFirstRoll(ref)) {
      newDiceState.rolledBy = getFirstRoller(ref);
    } else {
      newDiceState.rolledBy = newDiceState.nextRoller;
    }

    bool killedRollingOneThrice = false;

    if (shouldGiveAnotherTurn(newDiceState.roll)) {
      newDiceState.nextRoller = newDiceState.rolledBy;

      if (currentRoll == 1) {
        increaseRollOneRepeatedCount(ref, newDiceState.rolledBy);

        if (getRollOneRepeatedCount(ref) == 3) {
          bool killed = killPieceOfColorNearestHome(newDiceState.rolledBy, ref);

          killedRollingOneThrice = killed;

          resetRollOneRepeatedCount(ref);
        }
      } else {
        resetRollOneRepeatedCount(ref);
      }
    } else {
      newDiceState.nextRoller = getNextRoller(newDiceState.rolledBy, ref);
      resetRollOneRepeatedCount(ref);
    }

    setNewDiceState(ref, newDiceState);

    if (killedRollingOneThrice) {
      updateShouldRoll(ref, true);
      playSound(MySounds.rolledOneThrice);
    } else {
      updateShouldRoll(ref, shouldRoll(ref));
      playSound(MySounds.roll);
    }
  }

  bool killPieceOfColorNearestHome(String color, WidgetRef ref) {
    final pieces = ref.watch(piecesProvider);

    List<Piece> filteredPieces = pieces
        .where(
          (p) => p.id.contains(color) && p.freedFromPrison && !p.insideHome,
        )
        .toList();

    if (filteredPieces.isNotEmpty) {
      Piece piece = getTheNearestHomePiece(filteredPieces);

      piece.freedFromPrison = false;
      piece.insideHome = false;
      piece.insideHomeArea = false;
      piece.position = '';

      ref.read(piecesProvider.notifier).replaceProvidedPiecesOnly([piece]);

      return true;
    }
    return false;
  }

  Piece getTheNearestHomePiece(List<Piece> pieces) {
    List<Piece> piecesNotAboutToEnterHome =
        pieces.where((p) => !p.position.contains('-')).toList();

    List<Piece> piecesAboutToEnterHome =
        pieces.where((p) => p.position.contains('-')).toList();

    if (piecesAboutToEnterHome.isNotEmpty) {
      piecesAboutToEnterHome.sort(
        (a, b) => getNumberFromNearestHomePosition(a.position).compareTo(
          getNumberFromNearestHomePosition(b.position),
        ),
      );

      return piecesAboutToEnterHome.last;
    } else {
      List<Piece> piecesInsideHomeArea =
          piecesNotAboutToEnterHome.where((p) => p.insideHomeArea).toList();

      if (piecesInsideHomeArea.isEmpty) {
        piecesNotAboutToEnterHome.sort(
          (a, b) => int.parse(a.position).compareTo(
            int.parse(b.position),
          ),
        );

        return piecesNotAboutToEnterHome.last;
      } else {
        if (piecesInsideHomeArea.length > 1) {
          piecesInsideHomeArea.sort(
              (a, b) => int.parse(a.position).compareTo(int.parse(b.position)));
        }
        return piecesInsideHomeArea.last;
      }
    }
  }

  int getNumberFromNearestHomePosition(String position) {
    return int.parse(position.split('-')[1]);
  }

  String getNextRoller(String roller, WidgetRef ref) {
    final boardInitialState = ref.watch(boardInitialStateProvider);

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
    final boardInitialState = ref.watch(boardInitialStateProvider);

    var currentColor = diceState.nextRoller;

    if (!diceState.shouldRoll) {
      currentColor = diceState.rolledBy;
    }

    var currentRoll = diceState.roll;

    if (currentColor.isEmpty) {
      currentColor = boardInitialState.selectedColors[0];
      currentRoll = 1;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            rollDice(ref);
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
