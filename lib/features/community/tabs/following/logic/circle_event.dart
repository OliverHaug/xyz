import 'package:equatable/equatable.dart';

enum CircleTabMode { following, discover }

abstract class CircleEvent extends Equatable {
  const CircleEvent();
  @override
  List<Object?> get props => [];
}

class CircleStarted extends CircleEvent {
  const CircleStarted();
}

class CircleTabChanged extends CircleEvent {
  final CircleTabMode mode;
  const CircleTabChanged(this.mode);

  @override
  List<Object?> get props => [mode];
}

class CircleSearchChanged extends CircleEvent {
  final String query;
  const CircleSearchChanged(this.query);

  @override
  List<Object?> get props => [query];
}

class CircleRefreshRequested extends CircleEvent {
  const CircleRefreshRequested();
}

class FollowToggled extends CircleEvent {
  final String userId;
  const FollowToggled(this.userId);

  @override
  List<Object?> get props => [userId];
}
