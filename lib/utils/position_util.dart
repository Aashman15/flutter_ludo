import 'package:ludo/utils/color_util.dart';

const colorFirstPositions = {
  MyColors.blue: '9',
  MyColors.yellow: '22',
  MyColors.green: '35',
  MyColors.red: '48',
};

String getFirstPosition(String color) {
  if (!myColors.contains(color)) {
    return '';
  }

  return colorFirstPositions[color]!;
}

bool isAboutToEnterHomePosition(String position) {

  // position example : b-1
  if (position.contains('-')) {
    final positionNum = int.parse(position.split('-')[1]);
    return positionNum < 6;
  }
  return false;
}
