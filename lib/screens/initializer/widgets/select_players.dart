import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ludo/screens/initializer/widgets/number_of_players_button.dart';
import 'package:ludo/providers/board_initial_state_provider.dart';

class SelectPlayers extends ConsumerWidget {
  const SelectPlayers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initializerState = ref.watch(boardInitialStateProvider);
    final read = ref.read(boardInitialStateProvider.notifier);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Select or unselect players: *at least 2'),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            NumberOfPlayersButton(
              isActive: initializerState.selectedColors.contains('blue'),
              onTap: read.selectOrDisSelectColor,
              buttonText: 'blue',
            ),
            const SizedBox(width: 5),
            NumberOfPlayersButton(
              isActive: initializerState.selectedColors.contains('yellow'),
              onTap: read.selectOrDisSelectColor,
              buttonText: 'yellow',
            ),
            const SizedBox(width: 5),
            NumberOfPlayersButton(
              isActive: initializerState.selectedColors.contains('green'),
              onTap: read.selectOrDisSelectColor,
              buttonText: 'green',
            ),
            const SizedBox(width: 5),
            NumberOfPlayersButton(
              isActive: initializerState.selectedColors.contains('red'),
              onTap: read.selectOrDisSelectColor,
              buttonText: 'red',
            ),
          ],
        )
      ],
    );
  }
}
