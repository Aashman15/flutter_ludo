import 'package:flutter/material.dart';
import 'package:ludo/dice_state.dart';
import 'package:ludo/utils/table_cell_child_util.dart';

class YellowArea extends StatefulWidget {
  const YellowArea({super.key, required this.onPieceClick});

  final void Function(String pieceId) onPieceClick;

  @override
  State<StatefulWidget> createState() {
    return _YellowAreaWidget();
  }
}

class _YellowAreaWidget extends State<YellowArea> {
  String getPositionForFirstColumn(int tableRowIndex) {
    switch (tableRowIndex) {
      case 0:
        return '14';
      case 1:
        return 'y-5';
      case 2:
        return '26';
      default:
        throw Exception('index out of bound');
    }
  }

  String getPositionForSecondColumn(int tableRowIndex) {
    switch (tableRowIndex) {
      case 0:
        return '15';
      case 1:
        return 'y-4';
      case 2:
        return '25';
      default:
        throw Exception('index out of bound');
    }
  }

  String getPositionForThirdColumn(int tableRowIndex) {
    switch (tableRowIndex) {
      case 0:
        return '16';
      case 1:
        return 'y-3';
      case 2:
        return '24';
      default:
        throw Exception('index out of bound');
    }
  }

  String getPositionForFourthColumn(int tableRowIndex) {
    switch (tableRowIndex) {
      case 0:
        return '17';
      case 1:
        return 'y-2';
      case 2:
        return '23';
      default:
        throw Exception('index out of bound');
    }
  }

  String getPositionForFifthColumn(int tableRowIndex) {
    switch (tableRowIndex) {
      case 0:
        return '18';
      case 1:
        return 'y-1';
      case 2:
        return '22';
      default:
        throw Exception('index out of bound');
    }
  }

  String getPositionForSixthColumn(int tableRowIndex) {
    switch (tableRowIndex) {
      case 0:
        return '19';
      case 1:
        return '20';
      case 2:
        return '21';
      default:
        throw Exception('index out of bound');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<TableRow> tableRows = [];

    for (int i = 0; i < 3; i++) {
      String firstColPosition = getPositionForFirstColumn(i);
      String secondColPosition = getPositionForSecondColumn(i);
      String thirdColPosition = getPositionForThirdColumn(i);
      String fourthColPosition = getPositionForFourthColumn(i);
      String fifthColPosition = getPositionForFifthColumn(i);
      String sixthColPosition = getPositionForSixthColumn(i);

      tableRows.add(
        TableRow(
          children: [
            TableCell(
              key: Key(firstColPosition),
              child: Container(
                color: firstColPosition.contains('-')
                    ? const Color.fromARGB(80, 255, 235, 59)
                    : Colors.white,
                child: getTableCellChild(
                  firstColPosition,
                  diceState.rolledBy,
                  () {
                    widget.onPieceClick(
                      getPieceId(firstColPosition, diceState.rolledBy),
                    );
                  },
                ),
              ),
            ),
            TableCell(
              key: Key(secondColPosition),
              child: Container(
                color: secondColPosition.contains('-')
                    ? const Color.fromARGB(80, 255, 235, 59)
                    : Colors.white,
                child: getTableCellChild(
                  secondColPosition,
                  diceState.rolledBy,
                  () {
                    widget.onPieceClick(
                      getPieceId(secondColPosition, diceState.rolledBy),
                    );
                  },
                ),
              ),
            ),
            TableCell(
              key: Key(thirdColPosition),
              child: Container(
                color: thirdColPosition.contains('-')
                    ? const Color.fromARGB(80, 255, 235, 59)
                    : Colors.white,
                child: getTableCellChild(
                  thirdColPosition,
                  diceState.rolledBy,
                  () {
                    widget.onPieceClick(
                      getPieceId(thirdColPosition, diceState.rolledBy),
                    );
                  },
                ),
              ),
            ),
            TableCell(
              key: Key(fourthColPosition),
              child: Container(
                decoration: fourthColPosition == '17'
                    ? const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/star.png'),
                            fit: BoxFit.cover),
                      )
                    : null,
                color: fourthColPosition.contains('-')
                    ? const Color.fromARGB(80, 255, 235, 59)
                    : null,
                child: getTableCellChild(
                  fourthColPosition,
                  diceState.rolledBy,
                  () {
                    widget.onPieceClick(
                      getPieceId(fourthColPosition, diceState.rolledBy),
                    );
                  },
                ),
              ),
            ),
            TableCell(
              key: Key(fifthColPosition),
              child: Container(
                decoration: fifthColPosition == '22'
                    ? const BoxDecoration(
                        image: DecorationImage(
                            // star with background
                            image: AssetImage('assets/images/star.png'),
                            fit: BoxFit.cover),
                      )
                    : null,
                color: fifthColPosition.contains('-')
                    ? const Color.fromARGB(80, 255, 235, 59)
                    : null,
                child: getTableCellChild(
                  fifthColPosition,
                  diceState.rolledBy,
                  () {
                    widget.onPieceClick(
                      getPieceId(fifthColPosition, diceState.rolledBy),
                    );
                  },
                ),
              ),
            ),
            TableCell(
              key: Key(sixthColPosition),
              child: getTableCellChild(
                sixthColPosition,
                diceState.rolledBy,
                () {
                  widget.onPieceClick(
                    getPieceId(sixthColPosition, diceState.rolledBy),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }

    return Table(
      border: TableBorder.all(),
      children: [
        ...tableRows,
      ],
    );
  }
}
