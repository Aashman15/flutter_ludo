import 'package:flutter/material.dart';
import 'package:ludo/screens/board/widgets/my_table_cell.dart';

class GreenArea extends StatelessWidget {
  const GreenArea({super.key});

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
            MyTableCell(
                colIndex: 0, colPosition: firstColPosition, color: 'green'),
            MyTableCell(
                colIndex: 1, colPosition: secondColPosition, color: 'green'),
            MyTableCell(
                colIndex: 2, colPosition: thirdColPosition, color: 'green'),
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
