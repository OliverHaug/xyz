class MainState {
  final int currentIndex;
  const MainState({this.currentIndex = 0});

  MainState copyWith({int? currentIndex}) =>
      MainState(currentIndex: currentIndex ?? this.currentIndex);
}
