import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ludo/models/roll_one_repeated_count.dart';

class RollOneRepeatedCountProvider extends StateNotifier<RollOneRepeatedCount> {
  RollOneRepeatedCountProvider()
      : super(RollOneRepeatedCount(color: '', count: 0));

  void increaseRepeated(String color) {
    if (state.color == color) {
      state = RollOneRepeatedCount(color: color, count: state.count + 1);
    } else {
      state = RollOneRepeatedCount(color: color, count: 1);
    }
  }

  void resetState() {
    state = RollOneRepeatedCount(color: '', count: 0);
  }
}

final rollOneRepeatedCountProvider =
    StateNotifierProvider<RollOneRepeatedCountProvider, RollOneRepeatedCount>(
  (ref) => RollOneRepeatedCountProvider(),
);
