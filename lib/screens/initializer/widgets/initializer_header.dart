import 'package:flutter/cupertino.dart';

class InitializerHeader extends StatelessWidget {
  const InitializerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Welcome!!! \n Set initial state of your ludo board first. \n Thank you!!!',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ),
      textAlign: TextAlign.center,
    );
  }
}
