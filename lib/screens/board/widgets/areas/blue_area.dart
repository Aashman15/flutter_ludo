import 'package:flutter/material.dart';
import 'package:ludo/screens/board/widgets/my_table_cell.dart';
import 'package:ludo/utils/color_util.dart';

class BlueArea extends StatelessWidget {
  const BlueArea({super.key});

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
            MyTableCell(
                colIndex: 0, colPosition: firstColPosition, color: MyColors.blue),
            MyTableCell(
                colIndex: 1, colPosition: secondColPosition, color:MyColors.blue),
            MyTableCell(
                colIndex: 2, colPosition: thirdColPosition, color: MyColors.blue),
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
