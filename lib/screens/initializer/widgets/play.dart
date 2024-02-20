import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ludo/models/board_initial_state.dart';
import 'package:ludo/providers/board_initial_state_provider.dart';
import 'package:ludo/providers/pieces_provider.dart';
import 'package:ludo/screens/board/board_screen.dart';

class Play extends ConsumerWidget {
  const Play({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton.icon(
      onPressed: () {
        play(context, ref);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      icon: const Icon(Icons.play_arrow),
      label: const Text('Play'),
    );
  }

  void play(BuildContext context, WidgetRef ref) {
    final boardInitialState = ref.watch(initialStateProvider);
    if (boardInitialState.selectedColors.length < 2) {
      return;
    }

    updatePieces(ref, boardInitialState);

    navigateToLudoBoard(context);
  }

  void updatePieces(WidgetRef ref, BoardInitialState boardInitialState) {
    final pieces = ref.watch(piecesProvider);

    final updatedPieces = pieces
        .where(
          (piece) =>
              boardInitialState.selectedColors.contains(
                piece.id.split('-')[0],
              ) &&
              int.parse(piece.id.split('-')[1]) <=
                  boardInitialState.numberOfPieces,
        )
        .toList();

    ref.read(piecesProvider.notifier).setPieces(updatedPieces);
  }

  void navigateToLudoBoard(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const BoardScreen(),
      ),
    );
  }
}
