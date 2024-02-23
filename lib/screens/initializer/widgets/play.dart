import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ludo/providers/board_initial_state_provider.dart';
import 'package:ludo/screens/board/board_screen.dart';
import 'package:ludo/utils/piece_util.dart';

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
    if (isBoardInitialStateNotValid(ref)) {
      return;
    }

    updatePiecesAccordingToBoardInitialState(ref);

    navigateToBoardScreen(context);
  }

  bool isBoardInitialStateNotValid(WidgetRef ref) {
    final boardInitialState = ref.watch(boardInitialStateProvider);

    return boardInitialState.selectedColors.length < 2;
  }

  void navigateToBoardScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const BoardScreen(),
      ),
    );
  }
}
