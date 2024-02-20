import 'package:flutter/cupertino.dart';
import 'package:ludo/screens/board/widgets/areas/green_area.dart';
import 'package:ludo/screens/board/widgets/prison.dart';

class ThirdRow extends StatelessWidget {
  const ThirdRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Prison(color: 'green'),
        SizedBox(width: 20),
        SizedBox(width: 100, child: GreenArea()),
        SizedBox(width: 20),
        Prison(color: 'yellow')
      ],
    );
  }
}
