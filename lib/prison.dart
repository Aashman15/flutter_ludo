import 'package:flutter/material.dart';
import 'package:ludo/clicked_piece.dart';
import 'package:ludo/dice_state.dart';
import 'package:ludo/models/piece.dart';
import 'package:ludo/moved_rolled.dart';
import 'package:ludo/pieces.dart';
import 'package:ludo/utils/sound_utils.dart';

// eventhough the widget is immutable , it has to change for this requirement, so it will keep building
// the widget if any changes get occured

// ignore: must_be_immutable
class Prison extends StatefulWidget {
  Prison({super.key, required this.color, required this.onFreePiece});

  String color;
  void Function() onFreePiece;

  @override
  State<StatefulWidget> createState() {
    return _HouseState();
  }
}

class _HouseState extends State<Prison> {
  List<Piece> getUnFreedPieces() {
    return pieces
        .where((piece) =>
            piece.id.contains(widget.color) &&
            piece.position == '' &&
            !piece.freedFromPrison)
        .toList();
  }

  bool get shouldFree {
    return rolled && diceState.rolledBy == widget.color && diceState.roll == 1;
  }

  void freePiece(String pieceId) {
    clickedPiece = pieceId;
    if (!shouldFree) {
      playSound('error');
      return;
    }

    setState(() {
      for (int i = 0; i < pieces.length; i++) {
        if (pieces[i].id == pieceId) {
          pieces[i].freedFromPrison = true;
          if (widget.color == 'blue') {
            pieces[i].position = '9';
          } else if (widget.color == 'yellow') {
            pieces[i].position = '22';
          } else if (widget.color == 'green') {
            pieces[i].position = '35';
          } else if (widget.color == 'red') {
            pieces[i].position = '48';
          }
          moved = true;
          rolled = false;
          playSound('move');
          break;
        }
      }
      widget.onFreePiece();
    });
  }

  SizedBox getButtonSlot() {
    return SizedBox(
      height: 20,
      width: 20,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: const CircleBorder(),
        ),
        child: const Text(''),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Piece> pieces = getUnFreedPieces();

    for (Piece piece in pieces) {
      ElevatedButton originalButton = piece.button;
      piece.button = ElevatedButton(
        onPressed: () {
          freePiece(piece.id);
        },
        style: originalButton.style,
        child: originalButton.child,
      );
    }

    List<SizedBox> pieceButtons = pieces
        .map((p) => SizedBox(
              height: 20,
              width: 20,
              child: p.button,
            ))
        .toList();

    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            pieceButtons.isNotEmpty ? pieceButtons[0] : getButtonSlot(),
            const SizedBox(
              width: 5,
            ),
            pieceButtons.length > 1 ? pieceButtons[1] : getButtonSlot(),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            pieceButtons.length > 2 ? pieceButtons[2] : getButtonSlot(),
            const SizedBox(
              width: 5,
            ),
            pieceButtons.length > 3 ? pieceButtons[3] : getButtonSlot(),
          ],
        )
      ],
    );
  }
}
