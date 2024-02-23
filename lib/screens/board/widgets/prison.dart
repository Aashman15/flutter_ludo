import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ludo/models/dice.state.dart';
import 'package:ludo/models/piece.dart';
import 'package:ludo/screens/board/widgets/piece_button.dart';
import 'package:ludo/providers/clicked_piece_provider.dart';
import 'package:ludo/providers/dice_state_provider.dart';
import 'package:ludo/providers/pieces_provider.dart';
import 'package:ludo/utils/piece_util.dart';
import 'package:ludo/utils/position_util.dart';
import 'package:ludo/utils/sorts.dart';
import 'package:ludo/utils/sound_utils.dart';

class Prison extends ConsumerWidget {
  const Prison({super.key, required this.color});

  final String color;

  List<Piece> getColorPieces(List<Piece> pieces) {
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

    Piece piece = getPiece(pieceId, ref);
    piece.freedFromPrison = true;
    piece.position = getFirstPosition(color);

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
    List<SizedBox> sizedButtons = [];
    for (int i = 0; i < 4; i++) {
      if (pieces.length > i) {
        sizedButtons.add(
          getSizedButton(
            pieces[i].freedFromPrison ? getButtonSlot() : pieces[i].button,
          ),
        );
      } else {
        sizedButtons.add(getSizedButton(getButtonSlot()));
      }
    }

    return sizedButtons;
  }

  SizedBox getSizedButton(Widget child) {
    return SizedBox(
      height: 30,
      width: 30,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Piece> allPieces = ref.watch(piecesProvider);
    List<Piece> piecesOfColor = getPiecesOfColor(allPieces, color);

    sortPiecesOfColor(piecesOfColor, color);

    setOnPressedForUnFreedPieces(piecesOfColor, ref);

    List<SizedBox> buttons = getSizedPieceButtons(piecesOfColor);

    return Column(
      mainAxisSize: MainAxisSize.min,
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
