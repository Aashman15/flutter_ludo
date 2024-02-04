import 'package:flutter/material.dart';
import 'package:ludo/dice_state.dart';

Future<void> congratsDialog(BuildContext context) {
  String winner = diceState.rolledBy;

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Congrats $winner'),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Thank You'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
