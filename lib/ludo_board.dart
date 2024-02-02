// import 'package:flutter/material.dart';
// import 'package:ludo/blue_area.dart';
// import 'package:ludo/dice_roller.dart';
// import 'package:ludo/dice_state.dart';
// import 'package:ludo/green_area.dart';
// import 'package:ludo/models/piece.dart';
// import 'package:ludo/pieces.dart';
// import 'package:ludo/prison.dart';
// import 'package:ludo/red_area.dart';
// import 'package:ludo/yellow_area.dart';

// class LudoBoard extends StatefulWidget {
//   const LudoBoard({super.key});

//   @override
//   State<StatefulWidget> createState() {
//     return _LudoBoardState();
//   }
// }

// class _LudoBoardState extends State<LudoBoard> {
//   List<String> freedPieces = [];

//   String currentRoller = '';
//   int currentRoll = 0;

//   String nextRoller = '';

//   bool disableRolling = false;

//   void updatePiecePosition(String pieceId, int add, bool killed) {
//     setState(() {
//       List<String> splittedPieceId = pieceId.split('-');

//       for (int i = 0; i < pieces.length; i++) {
//         if (pieces[i].id == pieceId) {
//           if (killed) {
//             pieces[i].freedFromPrison = false;
//             pieces[i].insideHome = false;
//             pieces[i].insideHomeArea = false;
//             pieces[i].position = '';
//           } else {
//             try {
//               String currentPosition = pieces[i].position;

//               // handle color specific cases
//               if (splittedPieceId[0] == 'blue') {
//                 if (!currentPosition.contains('-')) {
//                   int nextPosition = int.parse(currentPosition) + add;
//                   if (nextPosition > 7 && pieces[i].insideHomeArea) {
//                     int difference = nextPosition - 7;
//                     pieces[i].position = 'b-$difference';
//                   } else {
//                     pieces[i].position = nextPosition.toString();
//                   }
//                 } else {
//                   List<String> splitted = currentPosition.split('-');
//                   int currentNum = int.parse(splitted[1]);
//                   int leftToReachHome = 6 - currentNum;

//                   if (add <= leftToReachHome) {
//                     int nextPosition = currentNum + add;

//                     if (nextPosition > 5) {
//                       pieces[i].insideHome = true;
//                       pieces[i].position = 'b-$nextPosition';
//                     } else {
//                       pieces[i].position = 'b-$nextPosition';
//                     }
//                   }
//                 }
//               }

//               if (splittedPieceId[0] == 'yellow') {
//                 if (!currentPosition.contains('-')) {
//                   int nextPosition = int.parse(currentPosition) + add;
//                   if (nextPosition > 20 && pieces[i].insideHomeArea) {
//                     int difference = nextPosition - 20;
//                     pieces[i].position = 'y-$difference';
//                   } else {
//                     pieces[i].position = nextPosition.toString();
//                   }
//                 } else {
//                   List<String> splitted = currentPosition.split('-');
//                   int currentNum = int.parse(splitted[1]);
//                   int leftToReachHome = 6 - currentNum;

//                   if (add <= leftToReachHome) {
//                     int nextPosition = currentNum + add;

//                     if (nextPosition > 5) {
//                       pieces[i].insideHome = true;
//                       pieces[i].position = 'y-$nextPosition';
//                     } else {
//                       pieces[i].position = 'y-$nextPosition';
//                     }
//                   }
//                 }
//               }

//               if (splittedPieceId[0] == 'green') {
//                 if (!currentPosition.contains('-')) {
//                   int nextPosition = int.parse(currentPosition) + add;
//                   if (nextPosition > 33 && pieces[i].insideHomeArea) {
//                     int difference = nextPosition - 33;
//                     pieces[i].position = 'y-$difference';
//                   } else {
//                     pieces[i].position = nextPosition.toString();
//                   }
//                 } else {
//                   List<String> splitted = currentPosition.split('-');
//                   int currentNum = int.parse(splitted[1]);
//                   int leftToReachHome = 6 - currentNum;

//                   if (add <= leftToReachHome) {
//                     int nextPosition = currentNum + add;

//                     if (nextPosition > 5) {
//                       pieces[i].insideHome = true;
//                       pieces[i].position = 'y-$nextPosition';
//                     } else {
//                       pieces[i].position = 'y-$nextPosition';
//                     }
//                   }
//                 }
//               }

//               if (splittedPieceId[0] == 'red') {
//                 if (!currentPosition.contains('-')) {
//                   int nextPosition = int.parse(currentPosition) + add;
//                   if (nextPosition > 46 && pieces[i].insideHomeArea) {
//                     int difference = nextPosition - 46;
//                     pieces[i].position = 'y-$difference';
//                   } else {
//                     pieces[i].position = nextPosition.toString();
//                   }
//                 } else {
//                   List<String> splitted = currentPosition.split('-');
//                   int currentNum = int.parse(splitted[1]);
//                   int leftToReachHome = 6 - currentNum;

//                   if (add <= leftToReachHome) {
//                     int nextPosition = currentNum + add;

//                     if (nextPosition > 5) {
//                       pieces[i].insideHome = true;
//                       pieces[i].position = 'y-$nextPosition';
//                     } else {
//                       pieces[i].position = 'y-$nextPosition';
//                     }
//                   }
//                 }
//               }
//               // ignore: empty_catches
//             } catch (e) {}
//           }
//           break;
//         }
//       }
//     });
//   }

//   void freePiece(String pieceToBeHidden) {
//     if (!freedPieces.contains(pieceToBeHidden)) {
//       setState(() {
//         freedPieces.add(pieceToBeHidden);
//       });
//     }
//   }

//   void onDiceRoll(String current, String next, int roll) {
//     setState(() {
//       currentRoller = current;
//       nextRoller = next;
//       currentRoll = roll;
//       disableRolling = shouldDisableRolling();
//       //
//     });
//   }

//   void rollDice() {
//     setState(() {
//       currentRoll = diceState.roll;
//       currentRoller = diceState.rolledBy;
//     });
//   }

//   bool shouldDisableRolling() {
//     List<Piece> freedPieces =
//         pieces.where((piece) => piece.freedFromPrison).toList();

//     if (freedPieces.isEmpty) {
//       return false;
//     }

//     // other conditions left

//     return true;
//   }

//   void onPieceClick(String pieceId) {
//     setState(() {
//       if (disableRolling && pieceId.split('-')[0] == currentRoller) {
//         updatePiecePosition(pieceId, currentRoll, false);
//         disableRolling = false;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<Row> rows = [];

//     rows.add(Row(
//       children: [
//         Container(
//           height: 200,
//           width: 100,
//           color: Colors.purple,
//           child: const Prison(
//             color: 'red',
//           ),
//         ),
//         Container(
//           height: 200,
//           width: 180,
//           margin: const EdgeInsets.only(left: 5),
//           color: Colors.purple,
//         ),
//         Container(
//           height: 200,
//           width: 100,
//           margin: const EdgeInsets.only(left: 5),
//           color: Colors.purple,
//           child: const Prison(color: 'blue'),
//         ),
//       ],
//     ));

//     rows.add(Row(
//       children: [
//         Container(
//           margin: const EdgeInsets.only(top: 5),
//           height: 200,
//           width: 165,
//           color: Colors.purple,
//         ),
//         Container(
//           height: 200,
//           width: 50,
//           margin: const EdgeInsets.only(left: 5, top: 5),
//           color: Colors.purple,
//         ),
//         Container(
//           height: 200,
//           width: 165,
//           margin: const EdgeInsets.only(left: 5, top: 5),
//           color: Colors.purple,
//         ),
//       ],
//     ));

//     rows.add(Row(
//       children: [
//         Container(
//           margin: const EdgeInsets.only(top: 5),
//           height: 200,
//           width: 100,
//           color: Colors.purple,
//           child: const Prison(
//             color: 'green',
//           ),
//         ),
//         Container(
//           height: 200,
//           width: 180,
//           margin: const EdgeInsets.only(left: 5, top: 5),
//           color: Colors.purple,
//         ),
//         Container(
//           height: 200,
//           width: 100,
//           margin: const EdgeInsets.only(left: 5, top: 5),
//           color: Colors.purple,
//           child: const Prison(
//             color: 'yellow',
//           ),
//         ),
//       ],
//     ));

//     // return Center(
//     //   child: Column(
//     //     mainAxisSize: MainAxisSize.min,
//     //     children: [
//     //       ...rows,
//     //       DiceRoller(
//     //         onDiceRoll: onDiceRoll,
//     //         disableRolling: disableRolling,
//     //         roller: currentRoller,
//     //       ),
//     //       Text('turn-$currentRoller'),
//     //     ],
//     //   ),
//     // );

//     return Column(
//       children: [const Prison(color: 'red'), DiceRoller(onDiceRoll: rollDice)],
//     );
//   }
// }
