import 'package:flutter/material.dart';
import 'package:ludo/screens/board/widgets/areas/blue_area.dart';
import 'package:ludo/screens/board/widgets/prison.dart';
import 'package:ludo/utils/color_util.dart';

class FirstRow extends StatelessWidget {
  const FirstRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Prison(color: MyColors.red),
        SizedBox(width: 20),
        SizedBox(width: 135, child: BlueArea()),
        SizedBox(width: 20),
        Prison(color: MyColors.blue),
      ],
    );
  }
}
