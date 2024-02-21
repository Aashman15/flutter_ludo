import 'package:flutter/material.dart';
import 'package:ludo/screens/board/widgets/my_table_cell.dart';

class YellowArea extends StatefulWidget {
  const YellowArea({super.key});

  @override
  State<StatefulWidget> createState() {
    return _YellowAreaState();
  }
}

class _YellowAreaState extends State<YellowArea> {
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
            MyTableCell(
                colIndex: 0, colPosition: firstColPosition, color: 'yellow'),
            MyTableCell(
                colIndex: 1, colPosition: secondColPosition, color: 'yellow'),
            MyTableCell(
                colIndex: 2, colPosition: thirdColPosition, color: 'yellow'),
            MyTableCell(
                colIndex: 3, colPosition: fourthColPosition, color: 'yellow'),
            MyTableCell(
                colIndex: 4, colPosition: fifthColPosition, color: 'yellow'),
            MyTableCell(
                colIndex: 5, colPosition: sixthColPosition, color: 'yellow'),
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
