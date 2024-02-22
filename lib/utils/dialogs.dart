import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ludo/providers/board_initial_state_provider.dart';
import 'package:ludo/providers/dice_state_provider.dart';
import 'package:ludo/providers/pieces_provider.dart';

String capitalizeFirstLetter(String input) {
  if (input.isEmpty) return input; // Return the string if it's empty
  return input[0].toUpperCase() + input.substring(1);
}

Future<void> showCongratsDialog(
    BuildContext context, String to, WidgetRef ref) {
  final color = capitalizeFirstLetter(to);

  var dialogContent = 'Unfortunately, you will not be able to play for other positions. But, we are glad to let you know that the feature is coming soon. But, for now please play another game. Thanks. 😊';

   int selectedColorsLength = ref.read(boardInitialStateProvider).selectedColors.length;

   if(selectedColorsLength <= 2){
     dialogContent = 'Game has been ended, please play another game. Thanks. 😊';
   }

  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Congratulations $color!!!'),
        content:  Text(dialogContent),
        actions: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Okay'),
            onPressed: () {
              ref.read(diceStateProvider.notifier).resetState();
              ref.read(piecesProvider.notifier).resetState();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> showPopScreenConfirmationDialog(
    BuildContext context, WidgetRef ref) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text(
          'Are you sure you want to leave this page? If you leave, you will not be able to continue this game again.',
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Nope'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Leave'),
            onPressed: () {
              ref.read(diceStateProvider.notifier).resetState();
              ref.read(piecesProvider.notifier).resetState();
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
