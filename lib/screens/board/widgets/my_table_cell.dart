import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ludo/models/table_cell_child.dart';
import 'package:ludo/providers/safe_zones_provider.dart';
import 'package:ludo/utils/color_util.dart';
import 'package:ludo/utils/dialogs.dart';
import 'package:ludo/models/dice.state.dart';
import 'package:ludo/models/piece.dart';
import 'package:ludo/providers/board_initial_state_provider.dart';
import 'package:ludo/providers/clicked_piece_provider.dart';
import 'package:ludo/providers/dice_state_provider.dart';
import 'package:ludo/providers/pieces_provider.dart';
import 'package:ludo/utils/move_piece_or_roll_dice_animation.util.dart';
import 'package:ludo/utils/position_util.dart';
import 'package:ludo/utils/sound_utils.dart';
import 'package:ludo/utils/table_cell_child_util.dart';
import 'package:ludo/utils/update_piece_position.dart';

const star = BoxDecoration(
  image: DecorationImage(
    image: AssetImage('assets/images/star.png'),
    fit: BoxFit.cover,
  ),
);

class MyTableCell extends ConsumerStatefulWidget {
  const MyTableCell(
      {super.key,
      required this.colIndex,
      required this.colPosition,
      required this.color});

  final int colIndex;
  final String colPosition;
  final String color;

  @override
  ConsumerState<MyTableCell> createState() {
    return _MyTableCellState();
  }
}

class _MyTableCellState extends ConsumerState<MyTableCell>
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

  BoxDecoration? getDecoration(String colPosition, WidgetRef ref) {
    final safePositions = ref.read(safePositionsProvider);

    if (!colPosition.contains('-')) {
      final position = int.parse(colPosition);
      if (safePositions.contains(position)) {
        return star;
      }
    }
    return null;
  }

  void clickPiece(String pieceId, WidgetRef ref, BuildContext context) {
    final diceState = ref.watch(diceStateProvider);
    final pieces = ref.watch(piecesProvider);

    if (!shouldUpdatePiecePosition(pieceId, diceState, pieces)) {
      playSound(MySounds.error);
      return;
    }

    ref.read(clickedPieceProvider.notifier).setClickedPiece(pieceId);

    String whatHappened = updatePiecePosition(pieceId, diceState.roll, ref);

    ref.read(diceStateProvider.notifier).setShouldRoll(true);

    bool congratulated = congratsIfNeeded(ref, context);

    if (congratulated) {
      whatHappened = 'congratulated';
    }

    playSoundBasedOnWhatHappened(whatHappened);
  }

  void playSoundBasedOnWhatHappened(String whatHappened) {
    if (whatHappened == 'congratulated') {
      playSound(MySounds.congratulations);
      return;
    }

    if (whatHappened == 'movedAndKilled') {
      playSound(MySounds.kill);
      return;
    }

    if (whatHappened == 'justMoved') {
      playSound(MySounds.move);
      return;
    }

    if (whatHappened == 'enteredHome') {
      playSound(MySounds.enterHome);
      return;
    }
  }

  bool congratsIfNeeded(WidgetRef ref, BuildContext context) {
    final diceState = ref.watch(diceStateProvider);
    final pieces = ref.watch(piecesProvider);
    final boardInitialState = ref.watch(boardInitialStateProvider);

    final piecesInsideHomeLength = pieces
        .where(
          (piece) => piece.id.contains(diceState.rolledBy) && piece.insideHome,
        )
        .length;

    if (piecesInsideHomeLength == boardInitialState.numberOfPieces) {
      showCongratsDialog(context, diceState.rolledBy, ref);
      return true;
    }
    return false;
  }

  bool shouldUpdatePiecePosition(
      String pieceId, DiceState diceState, List<Piece> pieces) {
    if (diceState.shouldRoll) {
      return false;
    }

    if (pieceId.isEmpty || !pieceId.contains(diceState.rolledBy)) {
      return false;
    }

    String piecePosition =
        pieces.where((element) => element.id == pieceId).first.position;

    if (piecePosition.contains('-')) {
      List<String> split = piecePosition.split('-');
      if (int.parse(split[1]) + diceState.roll > 6) {
        return false;
      }
    }

    return true;
  }

  double? getHeightForTableCell(color) {
    if (color == MyColors.blue || color == MyColors.green) {
      return 30;
    }

    if (color == MyColors.red || color == MyColors.yellow) {
      return 35;
    }

    return null;
  }

  Color? getColorForAboutToEnterHomeArea(String colPosition, String color) {
    if (isAboutToEnterHomePosition(colPosition)) {
      return getAboutToEnterHomePositionColor(color);
    }
    return null;
  }

  bool shouldAnimate(TableCellChild child) {
    if (!child.isPieceButton) {
      return false;
    }

    final diceState = ref.watch(diceStateProvider);
    final pieces = ref.watch(piecesProvider);

    final isActiveColor =
        child.pieceId!.split('-')[0].contains(diceState.rolledBy);

    final shouldUpdatePosition =
        shouldUpdatePiecePosition(child.pieceId!, diceState, pieces);

    return !diceState.shouldRoll && shouldUpdatePosition && isActiveColor;
  }

  Widget getSizedTableCellChild(TableCellChild tableCellChild) {
    if (!tableCellChild.isPieceButton) {
      return tableCellChild.child;
    }

    if (!shouldAnimate(tableCellChild)) {
      return SizedBox(
        height: 30,
        width: 30,
        child: tableCellChild.child,
      );
    }

    return AnimatedBuilder(
      animation: _animationController,
      child: tableCellChild.child,
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
    final diceState = ref.watch(diceStateProvider);

    final tableCellChild = getTableCellChild(
      widget.colPosition,
      diceState.rolledBy,
      () {
        clickPiece(
          getPieceId(widget.colPosition, diceState.rolledBy, ref),
          ref,
          context,
        );
      },
      ref,
    );

    final sizedTableCellChild = getSizedTableCellChild(tableCellChild);

    if (shouldAnimate(tableCellChild)) {
      _animationController.repeat();
    } else {
      _animationController.reverse();
    }

    return TableCell(
      key: Key(widget.colPosition.toString()),
      child: Container(
        alignment: Alignment.center,
        color:
            getColorForAboutToEnterHomeArea(widget.colPosition, widget.color),
        height: getHeightForTableCell(widget.color),
        decoration: getDecoration(widget.colPosition, ref),
        child: sizedTableCellChild,
      ),
    );



  }
}
