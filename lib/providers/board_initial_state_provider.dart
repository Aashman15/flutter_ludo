import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ludo/models/board_initial_state.dart';

Map<String, int> colorOrder = {
  'blue': 0,
  'yellow': 1,
  'green': 2,
  'red': 3,
};


void sortColors(List<String> colors){
  colors.sort((a, b) => colorOrder[a]!.compareTo(colorOrder[b]!));
}

class BoardInitialStateProvider extends StateNotifier<BoardInitialState> {
  BoardInitialStateProvider()
      : super(
          BoardInitialState(
            4,
            ['blue', 'yellow', 'green', 'red'],
            'blue',
          ),
        );

  void selectNumberOfPieces(String number) {
    state = BoardInitialState(
      int.parse(number),
      state.selectedColors,
      state.firstTurn,
    );
  }

  void selectFirstTurn(String color) {
    state = BoardInitialState(
      state.numberOfPieces,
      state.selectedColors,
      color,
    );
  }

  void selectOrDisSelectColor(String color) {
    if (state.selectedColors.contains(color)) {
      final selectedColors = state.selectedColors.where((c) => c != color).toList();
      // sorting is required as the list gets used later in the process for providing turn to a roller
      sortColors(selectedColors);

      state = BoardInitialState(
        state.numberOfPieces,
        selectedColors,
        state.firstTurn,
      );
    } else {
      final selectedColors = [...state.selectedColors, color];
      sortColors(selectedColors);

      state = BoardInitialState(
        state.numberOfPieces,
        [...state.selectedColors, color],
        state.firstTurn,
      );
    }
  }
}

final initialStateProvider =
    StateNotifierProvider<BoardInitialStateProvider, BoardInitialState>(
  (ref) => BoardInitialStateProvider(),
);
