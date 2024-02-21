import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ludo/providers/safe_zones_provider.dart';
import 'package:ludo/utils/congrats_dialog.dart';
import 'package:ludo/models/dice.state.dart';
import 'package:ludo/models/piece.dart';
import 'package:ludo/providers/board_initial_state_provider.dart';
import 'package:ludo/providers/clicked_piece_provider.dart';
import 'package:ludo/providers/dice_state_provider.dart';
import 'package:ludo/providers/pieces_provider.dart';
import 'package:ludo/utils/sound_utils.dart';
import 'package:ludo/utils/table_cell_child_util.dart';
import 'package:ludo/utils/update_piece_position.dart';

const star = BoxDecoration(
  image: DecorationImage(
    image: AssetImage('assets/images/star.png'),
    fit: BoxFit.cover,
  ),
);

class MyTableCell extends ConsumerWidget {
  const MyTableCell(
      {super.key,
      required this.colIndex,
      required this.colPosition,
      required this.color});

  final int colIndex;
  final String colPosition;
  final String color;

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
      playSound('error');
      return;
    }

    ref.read(clickedPieceProvider.notifier).setClickedPiece(pieceId);

    updatePiecePosition(pieceId, diceState.roll, ref);

    ref.read(diceStateProvider.notifier).setShouldRoll(true);

    congratsIfNeeded(ref, context);
  }

  void congratsIfNeeded(WidgetRef ref, BuildContext context) {
    final diceState = ref.watch(diceStateProvider);
    final pieces = ref.watch(piecesProvider);
    final boardInitialState = ref.watch(initialStateProvider);

    final piecesInsideHomeLength = pieces
        .where(
          (piece) => piece.id.contains(diceState.rolledBy) && piece.insideHome,
        )
        .length;

    if (piecesInsideHomeLength == boardInitialState.selectedColors.length) {
      congratsDialog(context, diceState.rolledBy);
    }
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diceState = ref.watch(diceStateProvider);

    return TableCell(
      key: Key(colPosition.toString()),
      child: Container(
        decoration: getDecoration(colPosition, ref),
        child: getTableCellChild(
          colPosition,
          diceState.rolledBy,
          () {
            clickPiece(
              getPieceId(colPosition, diceState.rolledBy, ref),
              ref,
              context,
            );
          },
          ref,
        ),
      ),
    );
  }
}
