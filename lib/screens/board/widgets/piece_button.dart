import 'package:flutter/material.dart';

class PieceButton extends StatelessWidget {
  const PieceButton({
    super.key,
    required this.backgroundColor,
    required this.onPressed,
  });

  final Color backgroundColor;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: const CircleBorder(),
      ),
      child: const Text(''),
    );
  }
}
