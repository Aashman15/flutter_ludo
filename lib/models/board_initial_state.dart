class BoardInitialState {
  BoardInitialState(
    this.numberOfPieces,
    this.selectedColors,
    this.firstTurn,
  );

  final int numberOfPieces;
  final List<String> selectedColors;
  final String firstTurn;
}
