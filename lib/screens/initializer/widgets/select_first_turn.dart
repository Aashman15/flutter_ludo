import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ludo/screens/initializer/widgets/number_of_players_button.dart';
import 'package:ludo/providers/board_initial_state_provider.dart';

class SelectFirstTurn extends ConsumerWidget {
  const SelectFirstTurn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(boardInitialStateProvider);
    return Column(
      children: [
        state.selectedColors.isNotEmpty
            ? const Text('First Turn')
            : const SizedBox(),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: getFirstTurnButtons(ref),
        )
      ],
    );
  }

  List<Container> getFirstTurnButtons(WidgetRef ref) {
    final state = ref.watch(boardInitialStateProvider);
    final read = ref.read(boardInitialStateProvider.notifier);

    return state.selectedColors
        .map(
          (color) => Container(
            margin: const EdgeInsets.only(left: 5),
            child: NumberOfPlayersButton(
              isActive: state.firstTurn == color,
              onTap: read.selectFirstTurn,
              buttonText: color,
            ),
          ),
        )
        .toList();
  }
}
