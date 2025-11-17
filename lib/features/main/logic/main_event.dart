abstract class MainEvent {}

class MainTabChanged extends MainEvent {
  final int index;
  MainTabChanged(this.index);
}
