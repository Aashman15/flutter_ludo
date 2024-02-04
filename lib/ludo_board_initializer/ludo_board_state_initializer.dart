import 'package:flutter/material.dart';
import 'package:ludo/ludo_board_initializer/number_of_players_button.dart';
import 'package:ludo/models/piece.dart';
import 'package:ludo/pieces.dart';
import 'package:ludo/states/first_roller.dart';
import 'package:ludo/states/number_of_pieces.dart';

class LudoBoardStateInitializer extends StatefulWidget {
  const LudoBoardStateInitializer(
      {super.key, required this.onChangeActiveScreen});

  final void Function(String screen) onChangeActiveScreen;

  @override
  State<StatefulWidget> createState() {
    return _LudoBoardStateInitializerState();
  }
}

class _LudoBoardStateInitializerState extends State<LudoBoardStateInitializer> {
  int numberOfPieces = 4;
  List<String> selectedColors = ['Blue', 'Yellow', 'Green', 'Red'];
  String firstTurn = 'Blue';

  void selectOrUnselectColor(String color) {
    setState(() {
      if (selectedColors.contains(color)) {
        selectedColors.remove(color);
        if (firstTurn == color && selectedColors.isNotEmpty) {
          firstTurn = selectedColors.first;
        }
      } else {
        selectedColors.add(color);
        if (!selectedColors.contains(firstTurn)) {
          firstTurn = color;
        }
      }
    });
  }

  void selectNumberOfPieces(String number) {
    setState(() {
      numberOfPieces = int.parse(number);
      numberOfPiecesToBePlayed = numberOfPieces;
    });
  }

  void selectFirstTurn(String color) {
    setState(() {
      firstTurn = color;
    });
  }

  List<Container> getFirstTurnButtons() {
    return selectedColors
        .map(
          (color) => Container(
            margin: const EdgeInsets.only(left: 5),
            child: NumberOfPlayersButton(
                isActive: firstTurn == color,
                onTap: selectFirstTurn,
                buttonText: color),
          ),
        )
        .toList();
  }

  void play() {
    if (selectedColors.length < 2) {
      return;
    }
    for (int i = 0; i < pieces.length; i++) {
      pieces[i].freedFromPrison = true;
      pieces[i].insideHome = true;
      pieces[i].insideHomeArea = true;
      pieces[i].position = '-6';
    }

    for (String color in selectedColors) {
      int added = 0;
      for (int i = 0; i < pieces.length; i++) {
        if (color.toLowerCase() == pieces[i].id.split('-')[0]) {
          if (added == numberOfPieces) {
            break;
          }
          pieces[i].freedFromPrison = false;
          pieces[i].insideHome = false;
          pieces[i].insideHomeArea = false;
          pieces[i].position = '';
          added++;
        }
      }
    }

    firstEverRoller = firstTurn.toLowerCase();

    widget.onChangeActiveScreen('board');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Welcome,\n Please, set your ludo board \n initial state!',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 100,
            width: 100,
            child: Image.asset('assets/images/ludo.png'),
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text('Select or unselect players: *at least 2'),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              NumberOfPlayersButton(
                isActive: selectedColors.contains('Blue'),
                onTap: selectOrUnselectColor,
                buttonText: 'Blue',
              ),
              const SizedBox(
                width: 5,
              ),
              NumberOfPlayersButton(
                isActive: selectedColors.contains('Yellow'),
                onTap: selectOrUnselectColor,
                buttonText: 'Yellow',
              ),
              const SizedBox(
                width: 5,
              ),
              NumberOfPlayersButton(
                isActive: selectedColors.contains('Green'),
                onTap: selectOrUnselectColor,
                buttonText: 'Green',
              ),
              const SizedBox(
                width: 5,
              ),
              NumberOfPlayersButton(
                isActive: selectedColors.contains('Red'),
                onTap: selectOrUnselectColor,
                buttonText: 'Red',
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          selectedColors.isNotEmpty
              ? const Text('First Turn')
              : const SizedBox(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: getFirstTurnButtons(),
          ),
          const Text('Number of pieces'),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              NumberOfPlayersButton(
                isActive: numberOfPieces == 1,
                onTap: selectNumberOfPieces,
                buttonText: '1',
              ),
              const SizedBox(
                width: 5,
              ),
              NumberOfPlayersButton(
                isActive: numberOfPieces == 2,
                onTap: selectNumberOfPieces,
                buttonText: '2',
              ),
              const SizedBox(
                width: 5,
              ),
              NumberOfPlayersButton(
                isActive: numberOfPieces == 3,
                onTap: selectNumberOfPieces,
                buttonText: '3',
              ),
              const SizedBox(
                width: 5,
              ),
              NumberOfPlayersButton(
                isActive: numberOfPieces == 4,
                onTap: selectNumberOfPieces,
                buttonText: '4',
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton.icon(
            onPressed: play,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            icon: const Icon(Icons.play_arrow),
            label: const Text('Play'),
          )
        ],
      ),
    );
  }
}
