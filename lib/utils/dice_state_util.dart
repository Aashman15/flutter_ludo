import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ludo/models/dice.state.dart';
import 'package:ludo/providers/board_initial_state_provider.dart';
import 'package:ludo/providers/dice_state_provider.dart';
import 'package:ludo/providers/roll-one-repeated_count_provider.dart';
import 'package:ludo/utils/should_move.dart';

const _anotherTurnGivers = [1,6];

void updateShouldRoll(WidgetRef ref, bool shouldRoll) {
  ref.read(diceStateProvider.notifier).setShouldRoll(shouldRoll);
}

bool isFirstRoll(WidgetRef ref) {
  final diceState = ref.watch(diceStateProvider);

  return diceState.rolledBy.isEmpty;
}

String getFirstRoller(WidgetRef ref) {
  final boardInitialState = ref.watch(boardInitialStateProvider);

  return boardInitialState.selectedColors.first;
}

DiceState getCopyOfDiceState(DiceState diceState){
  return DiceState(
    rolledBy: diceState.rolledBy,
    roll: diceState.roll,
    nextRoller: diceState.nextRoller,
    shouldRoll: diceState.shouldRoll,
  );
}

bool shouldGiveAnotherTurn(int roll){
  return _anotherTurnGivers.contains(roll);
}

void resetRollOneRepeatedCount(WidgetRef ref){
  ref.read(rollOneRepeatedCountProvider.notifier).resetState();
}

void increaseRollOneRepeatedCount(WidgetRef ref, String rolledBy) {
  ref.read(rollOneRepeatedCountProvider.notifier).increaseRepeated(rolledBy);
}

int getRollOneRepeatedCount(WidgetRef ref) {
  return ref.watch(rollOneRepeatedCountProvider).count;
}

void setNewDiceState(WidgetRef ref,DiceState diceState){
  ref.read(diceStateProvider.notifier).setState(diceState);
}

bool shouldRoll(WidgetRef ref) {
  return !shouldMove(ref);
}
