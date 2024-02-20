import 'package:flutter/material.dart';
import 'package:ludo/screens/board/widgets/areas/blue_area.dart';
import 'package:ludo/screens/board/widgets/prison.dart';

class FirstRow extends StatelessWidget {
  const FirstRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Prison(color: 'red'),
        SizedBox(width: 20),
        SizedBox(width: 100, child: BlueArea()),
        SizedBox(width: 20),
        Prison(color: 'blue')
      ],
    );
  }
}
