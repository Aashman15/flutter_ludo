import 'package:flutter/material.dart';
import 'package:ludo/dice_state.dart';
import 'package:ludo/utils/table_cell_child_util.dart';

class RedArea extends StatefulWidget {
  const RedArea({super.key, required this.onPieceClick});

  final void Function(String pieceId) onPieceClick;

  @override
  State<StatefulWidget> createState() {
    return _YellowAreaWidget();
  }
}

class _YellowAreaWidget extends State<RedArea> {
  String getPositionForFirstColumn(int tableRowIndex) {
    switch (tableRowIndex) {
      case 0:
        return '47';
      case 1:
        return '46';
      case 2:
        return '45';
      default:
        throw Exception('index out of bound');
    }
  }

  String getPositionForSecondColumn(int tableRowIndex) {
    switch (tableRowIndex) {
      case 0:
        return '48';
      case 1:
        return 'r-1';
      case 2:
        return '44';
      default:
        throw Exception('index out of bound');
    }
  }

  String getPositionForThirdColumn(int tableRowIndex) {
    switch (tableRowIndex) {
      case 0:
        return '49';
      case 1:
        return 'r-2';
      case 2:
        return '43';
      default:
        throw Exception('index out of bound');
    }
  }

  String getPositionForFourthColumn(int tableRowIndex) {
    switch (tableRowIndex) {
      case 0:
        return '50';
      case 1:
        return 'r-3';
      case 2:
        return '42';
      default:
        throw Exception('index out of bound');
    }
  }

  String getPositionForFifthColumn(int tableRowIndex) {
    switch (tableRowIndex) {
      case 0:
        return '51';
      case 1:
        return 'r-4';
      case 2:
        return '41';
      default:
        throw Exception('index out of bound');
    }
  }

  String getPositionForSixthColumn(int tableRowIndex) {
    switch (tableRowIndex) {
      case 0:
        return '52';
      case 1:
        return 'r-5';
      case 2:
        return '40';
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
            TableCell(
              key: Key(secondColPosition),
              child: Container(
                decoration: secondColPosition == '48'
                    ? const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/star.png'),
                            fit: BoxFit.cover),
                      )
                    : null,
                color: secondColPosition.contains('-')
                    ? const Color.fromARGB(80, 244, 67, 54)
                    : null,
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
                decoration: thirdColPosition == '43'
                    ? const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/star.png'),
                      fit: BoxFit.cover),
                )
                    : null,
                color:
                    thirdColPosition.contains('-')
                        ? const Color.fromARGB(80, 244, 67, 54)
                        : null,
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
                color: fourthColPosition.contains('-')
                    ? const Color.fromARGB(80, 244, 67, 54)
                    : Colors.white,
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
                color: fifthColPosition.contains('-')
                    ? const Color.fromARGB(80, 244, 67, 54)
                    : Colors.white,
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
              child: Container(
                color: thirdColPosition.contains('-')
                    ? const Color.fromARGB(80, 244, 67, 54)
                    : Colors.white,
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
