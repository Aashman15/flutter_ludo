import 'package:flutter/material.dart';
import 'package:ludo/utils/dialogs.dart';

class NumberOfPlayersButton extends StatelessWidget {
  const NumberOfPlayersButton(
      {super.key,
      required this.isActive,
      required this.onTap,
      required this.buttonText});

  final bool isActive;

  final void Function(String buttonText) onTap;

  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onTap(buttonText);
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0), // Adjust radius as needed
        ),
        backgroundColor: isActive ? Colors.black : null,
        foregroundColor: isActive ? Colors.white : null,
      ),
      child: Text(capitalizeFirstLetter(buttonText)),
    );
  }
}
