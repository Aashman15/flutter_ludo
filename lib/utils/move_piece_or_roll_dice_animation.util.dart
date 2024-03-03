  import 'package:flutter/animation.dart';

AnimationController getAnimationController(TickerProvider provider) {
    return AnimationController(
      vsync: provider,
      duration: const Duration(milliseconds: 500),
    );
  }

  Animation<int> getAnimation( AnimationController animationController) {
    return IntTween(begin: 0, end: 1).animate(animationController);
  }