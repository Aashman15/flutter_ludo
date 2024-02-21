import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ludo/models/dice.state.dart';

class DiceStateProvider extends StateNotifier<DiceState> {
  DiceStateProvider()
      : super(
          DiceState(
            rolledBy: '',
            roll: 0,
            nextRoller: '',
            shouldRoll: true,
          ),
        );

  void setShouldRoll(bool shouldRoll) {
    state = DiceState(
      rolledBy: state.rolledBy,
      roll: state.roll,
      nextRoller: state.nextRoller,
      shouldRoll: shouldRoll,
    );
  }

  void setNextRoller(String nextRoller){
    state =  DiceState(
      rolledBy: state.rolledBy,
      roll: state.roll,
      nextRoller: nextRoller,
      shouldRoll: state.shouldRoll,
    );
  }
}

final diceStateProvider = StateNotifierProvider<DiceStateProvider, DiceState>(
  (ref) => DiceStateProvider(),
);
