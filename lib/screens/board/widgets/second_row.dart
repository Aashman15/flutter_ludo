import 'package:flutter/material.dart';
import 'package:ludo/screens/board/widgets/areas/red_area.dart';
import 'package:ludo/screens/board/widgets/areas/yellow_area.dart';
import 'package:ludo/screens/board/widgets/dice_roller.dart';

class SecondRow extends StatelessWidget {
  const SecondRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(width: 150, child: RedArea()),
        SizedBox(width: 5),
        DiceRoller(),
        SizedBox(width: 5),
        SizedBox(width: 150, child: YellowArea()),
      ],
    );
  }
}
