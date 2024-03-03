import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ludo/models/piece.dart';
import 'package:ludo/screens/board/widgets/piece_button.dart';
import 'package:ludo/providers/dice_state_provider.dart';
import 'package:ludo/providers/pieces_provider.dart';
import 'package:ludo/utils/clicked_piece_util.dart';
import 'package:ludo/utils/dice_state_util.dart';
import 'package:ludo/utils/move_piece_or_roll_dice_animation.util.dart';
import 'package:ludo/utils/piece_util.dart';
import 'package:ludo/utils/position_util.dart';
import 'package:ludo/utils/sorts.dart';
import 'package:ludo/utils/sound_utils.dart';

class Prison extends ConsumerStatefulWidget {
  const Prison({super.key, required this.color});

  final String color;

  @override
  ConsumerState<Prison> createState() {
    return _PrisonState();
  }
}

class _PrisonState extends ConsumerState<Prison>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<int> _pieceAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = getAnimationController(this);
    _pieceAnimation = getAnimation(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool shouldFree(WidgetRef ref) {
    final diceState = ref.watch(diceStateProvider);

    return !diceState.shouldRoll &&
        diceState.rolledBy == widget.color &&
        diceState.roll == 1;
  }

  void freePiece(String pieceId, WidgetRef ref) {
    updateClickedPiece(ref, pieceId);

    if (!shouldFree(ref)) {
      playSound(MySounds.error);
      return;
    }

    Piece piece = getPiece(pieceId, ref);
    piece.freedFromPrison = true;
    piece.position = getFirstPosition(widget.color);

    updateShouldRoll(ref, true);

    playSound(MySounds.move);
  }

  PieceButton getButtonSlot() {
    return PieceButton(
      backgroundColor: Colors.white,
      onPressed: () {},
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

  List<PieceButton?> getButtonListOfLengthFour(List<Piece> pieces) {
    List<PieceButton?> pieceButtons = [];
    for (int i = 0; i < 4; i++) {
      if (pieces.length > i) {
        pieceButtons.add(
          pieces[i].freedFromPrison ? null : pieces[i].button,
        );
      } else {
        pieceButtons.add(null);
      }
    }

    return pieceButtons;
  }

  bool shouldAnimate() {
    final diceState = ref.watch(diceStateProvider);
    return !diceState.shouldRoll &&
        diceState.roll == 1 &&
        diceState.rolledBy == widget.color;
  }

  Widget getSizedButton(PieceButton? button) {
    if (button == null) {
      return SizedBox(height: 30, width: 30, child: getButtonSlot());
    }

    if (!shouldAnimate()) {
      return SizedBox(height: 30, width: 30, child: button);
    }

    return AnimatedBuilder(
      animation: _animationController,
      child: button,
      builder: (context, child) {
        return SizedBox(
          height: _pieceAnimation.value == 0 ? 30 : 25,
          width: _pieceAnimation.value == 0 ? 30 : 25,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Piece> allPieces = ref.watch(piecesProvider);
    List<Piece> piecesOfColor = getPiecesOfColor(allPieces, widget.color);

    sortPiecesOfColor(piecesOfColor, widget.color);

    setOnPressedForUnFreedPieces(piecesOfColor, ref);

    List<PieceButton?> buttons = getButtonListOfLengthFour(piecesOfColor);

    if (shouldAnimate()) {
      _animationController.repeat();
    } else {
      _animationController.reverse();
    }

    return SizedBox(
      height: 100,
      width: 100,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                getSizedButton(buttons[0]),
                const SizedBox(width: 20),
                getSizedButton(buttons[1])
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                getSizedButton(buttons[2]),
                const SizedBox(width: 20),
                getSizedButton(buttons[3]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
