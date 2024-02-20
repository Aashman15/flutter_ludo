import 'package:flutter/cupertino.dart';

class BoardImage extends StatelessWidget {
  const BoardImage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: Image.asset('assets/images/ludo.png'),
    );
  }
}
