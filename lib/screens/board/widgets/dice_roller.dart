import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ludo/models/board_initial_state.dart';
import 'package:ludo/models/dice.state.dart';
import 'package:ludo/models/piece.dart';
import 'package:ludo/providers/board_initial_state_provider.dart';
import 'package:ludo/providers/clicked_piece_provider.dart';
import 'package:ludo/providers/dice_state_provider.dart';
import 'package:ludo/providers/pieces_provider.dart';
import 'package:ludo/providers/roll-one-repeated_count_provider.dart';
import 'package:ludo/utils/should_move.dart';
import 'package:ludo/utils/sound_utils.dart';

final randomizer = Random();

class DiceRoller extends ConsumerWidget {
  const DiceRoller({super.key});

  void rollDice(
      WidgetRef ref, DiceState diceState, BoardInitialState initialState) {
    if (!diceState.shouldRoll) {
      playSound('error');
      return;
    }

    ref.read(clickedPieceProvider.notifier).setClickedPiece('');

    int currentRoll = randomizer.nextInt(6) + 1;

    diceState.roll = currentRoll;
    diceState.rolledBy = diceState.nextRoller;

    if (diceState.rolledBy.isEmpty) {
      diceState.rolledBy = initialState.selectedColors.first;
    }

    bool killedRollingOneThrice = false;

    if (currentRoll != 6 && currentRoll != 1) {
      diceState.nextRoller = getNextRoller(diceState.rolledBy, ref);
      ref.read(rollOneRepeatedCountProvider.notifier).resetState();
    } else {
      diceState.nextRoller = diceState.rolledBy;
      if (currentRoll == 1) {
        increaseRollOneRepeatedCount(ref, diceState.rolledBy);

        if (getRollOneRepeatedCount(ref) == 3) {
          bool killed = killPieceOfColorNearestHome(diceState.rolledBy, ref);

          killedRollingOneThrice = killed;

          ref.read(rollOneRepeatedCountProvider.notifier).resetState();
          ref.watch(diceStateProvider.notifier).setShouldRoll(true);
        }
      } else {
        ref.read(rollOneRepeatedCountProvider.notifier).resetState();
      }
    }

    if (!killedRollingOneThrice) {
      updateShouldRoll(ref);
      playSound('roll');
    } else {
      playSound('rolledOneThrice');
    }
  }

  int getRollOneRepeatedCount(WidgetRef ref) {
    return ref.watch(rollOneRepeatedCountProvider).count;
  }

  void increaseRollOneRepeatedCount(WidgetRef ref, String rolledBy) {
    ref.read(rollOneRepeatedCountProvider.notifier).increaseRepeated(rolledBy);
  }

  bool killPieceOfColorNearestHome(String color, WidgetRef ref) {
    final pieces = ref.watch(piecesProvider);

    List<Piece> freedPiecesOfColor =
        pieces.where((p) => p.id.contains(color) && p.freedFromPrison).toList();

    if (freedPiecesOfColor.isNotEmpty) {
      Piece piece = getTheNearestHomePiece(freedPiecesOfColor);

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

  void updateShouldRoll(WidgetRef ref) {
    final notifier = ref.read(diceStateProvider.notifier);

    if (shouldMove(ref)) {
      notifier.setShouldRoll(false);
    } else {
      notifier.setShouldRoll(true);
    }
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
            rollDice(ref, diceState, boardInitialState);
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
