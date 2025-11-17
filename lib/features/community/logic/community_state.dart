class CommunityState {
  final int tabIndex;
  const CommunityState({this.tabIndex = 0});

  CommunityState copyWith({int? tabIndex}) =>
      CommunityState(tabIndex: tabIndex ?? this.tabIndex);
}
