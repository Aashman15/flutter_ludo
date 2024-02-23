import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ludo/data/board_initial_state.dart';
import 'package:ludo/models/board_initial_state.dart';
import 'package:ludo/utils/color_util.dart';


void sortColors(List<String> colors) {
  colors.sort((a, b) => colorsOrder[a]!.compareTo(colorsOrder[b]!));
}

class BoardInitialStateProvider extends StateNotifier<BoardInitialState> {
  BoardInitialStateProvider()
      : super(
          boardInitialState,
        );

  void setState(BoardInitialState state) {
    state = state;
  }

  void selectNumberOfPieces(String number) {
    state = BoardInitialState(
      int.parse(number),
      state.selectedColors,
    );
  }

  void selectOrDisSelectColor(String color) {
    if (state.selectedColors.contains(color)) {
      final selectedColors =
          state.selectedColors.where((c) => c != color).toList();
      // sorting is required as the list gets used later in the process for providing turn to a roller
      sortColors(selectedColors);

      state = BoardInitialState(
        state.numberOfPieces,
        selectedColors,
      );
    } else {
      final selectedColors = [...state.selectedColors, color];
      sortColors(selectedColors);

      state = BoardInitialState(
        state.numberOfPieces,
        selectedColors,
      );
    }
  }
}

final boardInitialStateProvider =
    StateNotifierProvider<BoardInitialStateProvider, BoardInitialState>(
  (ref) => BoardInitialStateProvider(),
);
