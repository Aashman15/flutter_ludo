import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ludo/models/dice.state.dart';
import 'package:ludo/models/piece.dart';
import 'package:ludo/providers/board_initial_state_provider.dart';
import 'package:ludo/providers/dice_state_provider.dart';
import 'package:ludo/providers/pieces_provider.dart';
import 'package:ludo/utils/clicked_piece_util.dart';
import 'package:ludo/utils/dice_state_util.dart';
import 'package:ludo/utils/move_piece_or_roll_dice_animation.util.dart';
import 'package:ludo/utils/sound_utils.dart';
import 'package:uuid/uuid.dart';

final randomizer = Random();
const uuid = Uuid();

class DiceRoller extends ConsumerStatefulWidget {
  const DiceRoller({super.key});

  @override
  ConsumerState<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

class _DiceRollerState extends ConsumerState<DiceRoller>
    with TickerProviderStateMixin {
  bool _isRotating = false;

  late AnimationController _animationController;
  late Animation<int> _diceAnimation;

  late AnimationController _rotationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = getAnimationController(this);
    _diceAnimation = getAnimation(_animationController);

    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * pi,
    ).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  Future<bool> rotateImage() {
    final diceState = ref.watch(diceStateProvider);

    if (diceState.shouldRoll) {
      playSound(MySounds.roll);
    } else {
      playSound(MySounds.error);
    }

    _isRotating = true;
    _rotationController.reset();
    return _rotationController.forward().then((value) => _isRotating = false);
  }

  void rollDice(WidgetRef ref) {
    final diceState = ref.watch(diceStateProvider);
    final newDiceState = getCopyOfDiceState(diceState);

    if (!newDiceState.shouldRoll) {
      return;
    }

    resetClickedPiece(ref);

    int currentRoll = getRandomNumberBetweenOneAndSix();

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

        killedRollingOneThrice = killIfOneRolledThrice(ref, newDiceState);
      } else {
        resetRollOneRepeatedCount(ref);
      }
    } else {
      newDiceState.nextRoller = getNextRoller(newDiceState.rolledBy, ref);
      resetRollOneRepeatedCount(ref);
    }

    setNewDiceState(ref, newDiceState);

    if (!killedRollingOneThrice) {
      updateShouldRoll(ref, shouldRoll(ref));
    }
  }

  bool killIfOneRolledThrice(WidgetRef ref, DiceState diceState) {
    if (getRollOneRepeatedCount(ref) == 3) {
      killPieceOfColorNearestHome(diceState.rolledBy, ref);

      resetRollOneRepeatedCount(ref);

      diceState.shouldRoll = true;
      playSound(MySounds.rolledOneThrice);
      return true;
    }
    return false;
  }

  int getRandomNumberBetweenOneAndSix() {
    return randomizer.nextInt(6) + 1;
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
  Widget build(context) {
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

    if (diceState.shouldRoll) {
      _animationController.repeat();
    } else {
      _animationController.reverse();
    }

    return SizedBox(
      height: 50,
      width: 50,
      child: Center(
        child: InkWell(
          onTap: () async {
            if (!_isRotating) {
              await rotateImage();
              if(diceState.shouldRoll){
                rollDice(ref);
              }
            }
          },
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.rotate(
                angle: _rotationAnimation.value,
                child: Image.asset(
                  'assets/images/dice-$currentColor-$currentRoll.png',
                  width: _diceAnimation.value == 0 ? 50 : 45,
                  height: _diceAnimation.value == 0 ? 50 : 45,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
