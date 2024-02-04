import 'package:flutter/cupertino.dart';
import 'package:ludo/ludo_board_initializer/ludo_board_state_initializer.dart';
import 'package:ludo/ludo_board_v2.dart';
import 'package:ludo/states/active_screen.dart';

class MyLudoApp extends StatefulWidget {
  const MyLudoApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyLudoAppState();
  }
}

class _MyLudoAppState extends State<MyLudoApp> {
  void changeActiveScreen(String screen){
    setState(() {
      activeScreen = screen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return activeScreen == 'initializer'
        ?  LudoBoardStateInitializer(onChangeActiveScreen: changeActiveScreen,)
        : const LudoBoardV2();
  }
}
