import 'package:flutter/material.dart';
import 'package:ludo/dice_state.dart';
import 'package:ludo/utils/table_cell_child_util.dart';

class BlueArea extends StatefulWidget {
  const BlueArea({super.key, required this.onPieceClick});

  final void Function(String pieceId) onPieceClick;

  @override
  State<StatefulWidget> createState() {
    return _BlueAreaeState();
  }
}

class _BlueAreaeState extends State<BlueArea> {
  int getPositionForFirstColumn(int tableRowIndex) {
    switch (tableRowIndex) {
      case 0:
        return 6;
      case 1:
        return 5;
      case 2:
        return 4;
      case 3:
        return 3;
      case 4:
        return 2;
      case 5:
        return 1;
      default:
        throw Exception('index out of bound');
    }
  }

  String getPositionForSecondColumn(int tableRowIndex) {
    switch (tableRowIndex) {
      case 0:
        return 7.toString();
      case 1:
        return 'b-1';
      case 2:
        return 'b-2';
      case 3:
        return 'b-3';
      case 4:
        return 'b-4';
      case 5:
        return 'b-5';
      default:
        throw Exception('index out of bound');
    }
  }

  int getPositionForThirdColumn(int tableRowIndex) {
    switch (tableRowIndex) {
      case 0:
        return 8;
      case 1:
        return 9;
      case 2:
        return 10;
      case 3:
        return 11;
      case 4:
        return 12;
      case 5:
        return 13;
      default:
        throw Exception('index out of bound');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<TableRow> tableRows = [];

    for (int i = 0; i < 6; i++) {
      String firstColPosition = getPositionForFirstColumn(i).toString();
      String secondColPosition = getPositionForSecondColumn(i);
      String thirdColPosition = getPositionForThirdColumn(i).toString();

      tableRows.add(
        TableRow(
          children: [
            TableCell(
              key: Key(firstColPosition),
              child: Container(
                decoration: firstColPosition == '4'
                    ? const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/star.png'),
                            fit: BoxFit.cover),
                      )
                    : null,
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
                    ? const Color.fromARGB(80, 33, 150, 243)
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
                decoration: thirdColPosition == '9'
                    ? const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/star.png'),
                            fit: BoxFit.cover),
                      )
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
