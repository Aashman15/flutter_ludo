import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ludo/screens/initializer/widgets/number_of_players_button.dart';
import 'package:ludo/providers/board_initial_state_provider.dart';
import 'package:ludo/utils/color_util.dart';

class SelectPlayers extends ConsumerWidget {
  const SelectPlayers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initializerState = ref.watch(boardInitialStateProvider);
    final read = ref.read(boardInitialStateProvider.notifier);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Select or unselect players.'),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            NumberOfPlayersButton(
              isActive: initializerState.selectedColors.contains(MyColors.blue),
              onTap: read.selectOrDisSelectColor,
              buttonText: MyColors.blue,
            ),
            const SizedBox(width: 5),
            NumberOfPlayersButton(
              isActive: initializerState.selectedColors.contains(MyColors.yellow),
              onTap: read.selectOrDisSelectColor,
              buttonText: MyColors.blue,
            ),
            const SizedBox(width: 5),
            NumberOfPlayersButton(
              isActive: initializerState.selectedColors.contains(MyColors.green),
              onTap: read.selectOrDisSelectColor,
              buttonText: MyColors.blue,
            ),
            const SizedBox(width: 5),
            NumberOfPlayersButton(
              isActive: initializerState.selectedColors.contains(MyColors.red),
              onTap: read.selectOrDisSelectColor,
              buttonText: MyColors.blue,
            ),
          ],
        )
      ],
    );
  }
}
