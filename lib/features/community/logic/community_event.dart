abstract class CommunityEvent {}

class CommunityTabChanged extends CommunityEvent {
  final int index;
  CommunityTabChanged(this.index);
}
