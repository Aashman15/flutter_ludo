import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ludo/screens/initializer/widgets/number_of_players_button.dart';
import 'package:ludo/providers/board_initial_state_provider.dart';

class SelectNoOfPieces extends ConsumerWidget {
  const SelectNoOfPieces({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(boardInitialStateProvider);
    final read = ref.read(boardInitialStateProvider.notifier);

    return Column(
      children: [
        const Text('Number of pieces'),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            NumberOfPlayersButton(
              isActive: state.numberOfPieces == 1,
              onTap: read.selectNumberOfPieces,
              buttonText: '1',
            ),
            const SizedBox(
              width: 5,
            ),
            NumberOfPlayersButton(
              isActive: state.numberOfPieces == 2,
              onTap: read.selectNumberOfPieces,
              buttonText: '2',
            ),
            const SizedBox(
              width: 5,
            ),
            NumberOfPlayersButton(
              isActive: state.numberOfPieces == 3,
              onTap: read.selectNumberOfPieces,
              buttonText: '3',
            ),
            const SizedBox(
              width: 5,
            ),
            NumberOfPlayersButton(
              isActive: state.numberOfPieces == 4,
              onTap: read.selectNumberOfPieces,
              buttonText: '4',
            ),
          ],
        ),
      ],
    );
  }
}
