// import 'package:flutter/material.dart';
// import 'package:ludo/dice_roller.dart';
// import 'package:ludo/dice_state.dart';
// import 'package:ludo/areas/green_area.dart';
// import 'package:ludo/moved_rolled.dart';
// import 'package:ludo/pieces.dart';
// import 'package:ludo/prison.dart';
// import 'package:ludo/should_move.dart';
//
// class Test extends StatefulWidget {
//   const Test({super.key});
//
//   @override
//   State<StatefulWidget> createState() {
//     return _TestState();
//   }
// }
//
// class _TestState extends State<Test> {
//   void updatePiecePosition(String pieceId, int add, bool killed) {
//     List<String> splittedPieceId = pieceId.split('-');
//
//     for (int i = 0; i < pieces.length; i++) {
//       if (pieces[i].id == pieceId) {
//         if (killed) {
//           pieces[i].freedFromPrison = false;
//           pieces[i].insideHome = false;
//           pieces[i].insideHomeArea = false;
//           pieces[i].position = '';
//         } else {
//           try {
//             String currentPosition = pieces[i].position;
//
//             // handle color specific cases
//             if (splittedPieceId[0] == 'blue') {
//               if (!currentPosition.contains('-')) {
//                 int nextPosition = int.parse(currentPosition) + add;
//                 if (nextPosition > 7 && pieces[i].insideHomeArea) {
//                   int difference = nextPosition - 7;
//                   pieces[i].position = 'b-$difference';
//                 } else {
//                   pieces[i].position = nextPosition.toString();
//                 }
//               } else {
//                 List<String> splitted = currentPosition.split('-');
//                 int currentNum = int.parse(splitted[1]);
//                 int leftToReachHome = 6 - currentNum;
//
//                 if (add <= leftToReachHome) {
//                   int nextPosition = currentNum + add;
//
//                   if (nextPosition > 5) {
//                     pieces[i].insideHome = true;
//                     pieces[i].position = 'b-$nextPosition';
//                   } else {
//                     pieces[i].position = 'b-$nextPosition';
//                   }
//                 }
//               }
//             }
//
//             if (splittedPieceId[0] == 'yellow') {
//               if (!currentPosition.contains('-')) {
//                 int nextPosition = int.parse(currentPosition) + add;
//                 if (nextPosition > 20 && pieces[i].insideHomeArea) {
//                   int difference = nextPosition - 20;
//                   pieces[i].position = 'y-$difference';
//                 } else {
//                   pieces[i].position = nextPosition.toString();
//                 }
//               } else {
//                 List<String> splitted = currentPosition.split('-');
//                 int currentNum = int.parse(splitted[1]);
//                 int leftToReachHome = 6 - currentNum;
//
//                 if (add <= leftToReachHome) {
//                   int nextPosition = currentNum + add;
//
//                   if (nextPosition > 5) {
//                     pieces[i].insideHome = true;
//                     pieces[i].position = 'y-$nextPosition';
//                   } else {
//                     pieces[i].position = 'y-$nextPosition';
//                   }
//                 }
//               }
//             }
//
//             if (splittedPieceId[0] == 'green') {
//               if (!currentPosition.contains('-')) {
//                 int nextPosition = int.parse(currentPosition) + add;
//                 if (nextPosition > 33 && pieces[i].insideHomeArea) {
//                   int difference = nextPosition - 33;
//                   pieces[i].position = 'y-$difference';
//                 } else {
//                   pieces[i].position = nextPosition.toString();
//                 }
//               } else {
//                 List<String> splitted = currentPosition.split('-');
//                 int currentNum = int.parse(splitted[1]);
//                 int leftToReachHome = 6 - currentNum;
//
//                 if (add <= leftToReachHome) {
//                   int nextPosition = currentNum + add;
//
//                   if (nextPosition > 5) {
//                     pieces[i].insideHome = true;
//                     pieces[i].position = 'y-$nextPosition';
//                   } else {
//                     pieces[i].position = 'y-$nextPosition';
//                   }
//                 }
//               }
//             }
//
//             if (splittedPieceId[0] == 'red') {
//               if (!currentPosition.contains('-')) {
//                 int nextPosition = int.parse(currentPosition) + add;
//                 if (nextPosition > 46 && pieces[i].insideHomeArea) {
//                   int difference = nextPosition - 46;
//                   pieces[i].position = 'y-$difference';
//                 } else {
//                   pieces[i].position = nextPosition.toString();
//                 }
//               } else {
//                 List<String> splitted = currentPosition.split('-');
//                 int currentNum = int.parse(splitted[1]);
//                 int leftToReachHome = 6 - currentNum;
//
//                 if (add <= leftToReachHome) {
//                   int nextPosition = currentNum + add;
//
//                   if (nextPosition > 5) {
//                     pieces[i].insideHome = true;
//                     pieces[i].position = 'y-$nextPosition';
//                   } else {
//                     pieces[i].position = 'y-$nextPosition';
//                   }
//                 }
//               }
//             }
//             // ignore: empty_catches
//           } catch (e) {}
//         }
//         break;
//       }
//     }
//   }
//
//   void rollDice() {
//     setState(() {
//       print('hi');
//     });
//   }
//
//   void onFreePiece() {
//     setState(() {
//       print('hi');
//     });
//   }
//
//   void onPieceClick(String pieceId) {
//     print('hi');
//     setState(() {
//       if (!rolled) {
//         return;
//       }
//       if (shouldMove) {
//         updatePiecePosition(pieceId, diceState.roll, false);
//       }
//       rolled = false;
//       moved = true;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             const SizedBox(
//               width: 20,
//             ),
//             Prison(
//               color: 'green',
//               onFreePiece: onFreePiece,
//             ),
//           ],
//         ),
//         const Text('green area'),
//         GreenArea(onPieceClick: onPieceClick),
//         DiceRoller(onDiceRoll: rollDice),
//       ],
//     );
//   }
// }
