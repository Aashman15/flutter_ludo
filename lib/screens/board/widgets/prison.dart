import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ludo/models/dice.state.dart';
import 'package:ludo/models/piece.dart';
import 'package:ludo/data/pieces.dart';
import 'package:ludo/screens/board/widgets/piece_button.dart';
import 'package:ludo/providers/clicked_piece_provider.dart';
import 'package:ludo/providers/dice_state_provider.dart';
import 'package:ludo/providers/pieces_provider.dart';
import 'package:ludo/utils/sound_utils.dart';

class Prison extends ConsumerWidget {
  const Prison({super.key, required this.color});

  final String color;

  List<Piece> getColorPieces() {
    return pieces.where((piece) => piece.id.contains(color)).toList();
  }

  bool shouldFree(DiceState diceState) {
    return !diceState.shouldRoll &&
        diceState.rolledBy == color &&
        diceState.roll == 1;
  }

  void freePiece(String pieceId, WidgetRef ref) {
    final diceState = ref.watch(diceStateProvider);

    ref.read(clickedPieceProvider.notifier).setClickedPiece(pieceId);

    if (!shouldFree(diceState)) {
      playSound('error');
      return;
    }

    final pieces = ref.watch(piecesProvider);

    Piece piece = pieces.where((piece) => piece.id == pieceId).toList()[0];
    piece.freedFromPrison = true;

    if (color == 'blue') {
      piece.position = '9';
    } else if (color == 'yellow') {
      piece.position = '22';
    } else if (color == 'green') {
      piece.position = '35';
    } else if (color == 'red') {
      piece.position = '48';
    }

    ref.read(diceStateProvider.notifier).setShouldRoll(true);
    playSound('move');
  }

  SizedBox getButtonSlot() {
    return SizedBox(
      height: 20,
      width: 20,
      child: PieceButton(
        backgroundColor: Colors.white,
        onPressed: () {},
      ),
    );
  }

  void setOnPressedForUnFreedPieces(List<Piece> pieces, WidgetRef ref) {
    for (Piece piece in pieces) {
      if (!piece.freedFromPrison) {
        PieceButton originalButton = piece.button;
        piece.button = PieceButton(
          onPressed: () {
            freePiece(piece.id, ref);
          },
          backgroundColor: originalButton.backgroundColor,
        );
      }
    }
  }

  List<SizedBox> getSizedPieceButtons(List<Piece> pieces) {
    return pieces
        .map((piece) => SizedBox(
              height: 20,
              width: 20,
              child: piece.freedFromPrison ? getButtonSlot() : piece.button,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Piece> pieces = getColorPieces();

    setOnPressedForUnFreedPieces(pieces, ref);

    List<SizedBox> buttons = getSizedPieceButtons(pieces);

    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [buttons[0], const SizedBox(width: 20), buttons[1]],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [buttons[2], const SizedBox(width: 20), buttons[3]],
        )
      ],
    );
  }
}
