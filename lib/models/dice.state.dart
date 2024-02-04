class DiceState {
  DiceState(
      {required this.rolledBy,
      required this.roll,
      required this.nextRoller,
      required this.previousRoller,
      required this.previousRoll,
      required this.rolled});

  String rolledBy;
  int roll;
  String nextRoller;
  String previousRoller;
  int previousRoll;
  bool rolled;
}
