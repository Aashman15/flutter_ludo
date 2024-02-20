import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ludo/providers/dice_state_provider.dart';
import 'package:ludo/screens/board/widgets/first_row.dart';
import 'package:ludo/screens/board/widgets/second_row.dart';
import 'package:ludo/screens/board/widgets/third_row.dart';

class BoardScreen extends ConsumerWidget {
  const BoardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diceState = ref.watch(diceStateProvider);
    String message = diceState.shouldRoll ? 'Roll' : 'Move';

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message),
            const SizedBox(height: 50),
            const FirstRow(),
            const SizedBox(height: 10),
            const SecondRow(),
            const SizedBox(height: 10),
            const ThirdRow()
          ],
        ),
      ),
    );
  }
}
