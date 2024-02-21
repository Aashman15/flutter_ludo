import 'package:flutter/material.dart';
import 'package:ludo/screens/initializer/widgets/board_image.dart';
import 'package:ludo/screens/initializer/widgets/initializer_header.dart';
import 'package:ludo/screens/initializer/widgets/play.dart';
import 'package:ludo/screens/initializer/widgets/select_first_turn.dart';
import 'package:ludo/screens/initializer/widgets/select_no_of_pieces.dart';
import 'package:ludo/screens/initializer/widgets/select_players.dart';

class LudoBoardInitializerScreen extends StatelessWidget {
  const LudoBoardInitializerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InitializerHeader(),
              SizedBox(height: 30),
              BoardImage(),
              SizedBox(height: 30),
              SelectPlayers(),
              SizedBox(height: 10),
              SelectFirstTurn(),
              SizedBox(height: 10),
              SelectNoOfPieces(),
              SizedBox(height: 30),
              Play(),
            ],
        ),
      ),
    );
  }
}
