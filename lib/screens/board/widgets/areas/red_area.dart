import 'package:flutter/material.dart';
import 'package:ludo/screens/board/widgets/my_table_cell.dart';

class RedArea extends StatelessWidget {
  const RedArea({super.key});

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
            MyTableCell(
                colIndex: 0, colPosition: firstColPosition, color: 'red'),
            MyTableCell(
                colIndex: 1, colPosition: secondColPosition, color: 'red'),
            MyTableCell(
                colIndex: 2, colPosition: thirdColPosition, color: 'red'),
            MyTableCell(
                colIndex: 3, colPosition: fourthColPosition, color: 'red'),
            MyTableCell(
                colIndex: 4, colPosition: fifthColPosition, color: 'red'),
            MyTableCell(
                colIndex: 5, colPosition: sixthColPosition, color: 'red'),
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
