import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ludo/screens/board/widgets/first_row.dart';
import 'package:ludo/screens/board/widgets/second_row.dart';
import 'package:ludo/screens/board/widgets/third_row.dart';
import 'package:ludo/utils/dialogs.dart';

class BoardScreen extends ConsumerWidget {
  const BoardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        showPopScreenConfirmationDialog(context, ref);
      },
      child: Scaffold(
        body: Center(
            child: Container(
          color: const Color.fromARGB(255, 234, 228, 236),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FirstRow(),
              SizedBox(height: 10),
              SecondRow(),
              SizedBox(height: 10),
              ThirdRow()
            ],
          ),
        )),
      ),
    );
  }
}
