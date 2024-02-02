import 'package:flutter/material.dart';
import 'package:ludo/dice_state.dart';
import 'package:ludo/utils/table_cell_child_util.dart';

class GreenArea extends StatefulWidget {
  const GreenArea({super.key, required this.onPieceClick});

  final void Function(String pieceId) onPieceClick;

  @override
  State<StatefulWidget> createState() {
    return _GreenAreaState();
  }
}

class _GreenAreaState extends State<GreenArea> {
  String getPositionForFirstColumn(int tableRowIndex) {
    switch (tableRowIndex) {
      case 0:
        return '39';
      case 1:
        return '38';
      case 2:
        return '37';
      case 3:
        return '36';
      case 4:
        return '35';
      case 5:
        return '34';
      default:
        throw Exception('index out of bound');
    }
  }

  String getPositionForSecondColumn(int tableRowIndex) {
    switch (tableRowIndex) {
      case 0:
        return 'g-5';
      case 1:
        return 'g-4';
      case 2:
        return 'g-3';
      case 3:
        return 'g-2';
      case 4:
        return 'g-1';
      case 5:
        return '33';
      default:
        throw Exception('index out of bound');
    }
  }

  String getPositionForThirdColumn(int tableRowIndex) {
    switch (tableRowIndex) {
      case 0:
        return '27';
      case 1:
        return '28';
      case 2:
        return '29';
      case 3:
        return '30';
      case 4:
        return '31';
      case 5:
        return '32';
      default:
        throw Exception('index out of bound');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<TableRow> tableRows = [];

    for (int i = 0; i < 6; i++) {
      String firstColPosition = getPositionForFirstColumn(i);
      String secondColPosition = getPositionForSecondColumn(i);
      String thirdColPosition = getPositionForThirdColumn(i);

      tableRows.add(
        TableRow(
          children: [
            TableCell(
              key: Key(firstColPosition),
              child: Container(
                // star with background
                decoration: firstColPosition == '35'
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
                    ? const Color.fromARGB(80, 76, 175, 80)
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
                decoration: thirdColPosition == '30'
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
