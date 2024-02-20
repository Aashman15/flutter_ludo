class DiceState {
  DiceState({
    required this.rolledBy,
    required this.roll,
    required this.nextRoller,
    required this.shouldRoll,
  });

  String rolledBy;
  int roll;
  String nextRoller;
  bool shouldRoll;
}
