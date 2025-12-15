import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xyz/features/community/tabs/following/data/circle_repository.dart';
import 'package:xyz/features/community/tabs/following/data/circle_user_model.dart';
import 'circle_event.dart';
import 'circle_state.dart';

class CircleBloc extends Bloc<CircleEvent, CircleState> {
  final CircleRepository _repo;

  CircleBloc(this._repo) : super(const CircleState()) {
    on<CircleStarted>(_onStarted);
    on<CircleTabChanged>(_onTabChanged);
    on<CircleSearchChanged>(_onSearchChanged);
    on<CircleRefreshRequested>(_onRefresh);
    on<FollowToggled>(_onFollowToggled);
  }

  Future<void> _onStarted(CircleStarted e, Emitter<CircleState> emit) async {
    emit(state.copyWith(status: CircleStatus.loading, error: null));
    try {
      final followingRaw = await _repo.fetchFollowing(limit: 50);
      final following = followingRaw
          .map((m) => CircleUserModel.fromMap(m).copyWith(isFollowed: true))
          .toList();

      // suggested = discover ohne query (RPC sollte is_followed liefern)
      final suggestedRaw = await _repo.fetchDiscover(query: '', limit: 50);
      final suggestedAll = suggestedRaw.map(CircleUserModel.fromMap).toList();

      // remove already-following (und optional self – falls RPC das nicht macht)
      final followingIds = following.map((e) => e.user.id).toSet();
      final suggested = suggestedAll
          .where((u) => !followingIds.contains(u.user.id))
          .toList();

      emit(
        state.copyWith(
          status: CircleStatus.success,
          following: following,
          suggested: suggested,
          discover: const [],
        ),
      );
    } catch (err) {
      emit(state.copyWith(status: CircleStatus.failure, error: err.toString()));
    }
  }

  Future<void> _onTabChanged(
    CircleTabChanged e,
    Emitter<CircleState> emit,
  ) async {
    emit(state.copyWith(mode: e.mode));
    if (e.mode == CircleTabMode.discover) {
      add(const CircleRefreshRequested());
    }
  }

  Future<void> _onSearchChanged(
    CircleSearchChanged e,
    Emitter<CircleState> emit,
  ) async {
    emit(state.copyWith(query: e.query));

    // nur in Discover aktiv nachladen (wie Mockup)
    if (state.mode == CircleTabMode.discover) {
      add(const CircleRefreshRequested());
    }
  }

  Future<void> _onRefresh(
    CircleRefreshRequested e,
    Emitter<CircleState> emit,
  ) async {
    emit(state.copyWith(status: CircleStatus.loading, error: null));
    try {
      if (state.mode == CircleTabMode.following) {
        final raw = await _repo.fetchFollowing(limit: 50);
        final following = raw
            .map((m) => CircleUserModel.fromMap(m).copyWith(isFollowed: true))
            .toList();
        emit(
          state.copyWith(status: CircleStatus.success, following: following),
        );
        return;
      }

      // Discover
      final q = state.query.trim();
      if (q.isEmpty) {
        // refresh suggested
        final suggestedRaw = await _repo.fetchDiscover(query: '', limit: 50);
        final suggestedAll = suggestedRaw.map(CircleUserModel.fromMap).toList();
        final followingIds = state.following.map((e) => e.user.id).toSet();
        final suggested = suggestedAll
            .where((u) => !followingIds.contains(u.user.id))
            .toList();

        emit(
          state.copyWith(
            status: CircleStatus.success,
            suggested: suggested,
            discover: const [],
          ),
        );
      } else {
        final raw = await _repo.fetchDiscover(query: q, limit: 50);
        emit(
          state.copyWith(
            status: CircleStatus.success,
            discover: raw.map(CircleUserModel.fromMap).toList(),
          ),
        );
      }
    } catch (err) {
      emit(state.copyWith(status: CircleStatus.failure, error: err.toString()));
    }
  }

  Future<void> _onFollowToggled(
    FollowToggled e,
    Emitter<CircleState> emit,
  ) async {
    CircleUserModel? toggled;

    List<CircleUserModel> toggle(List<CircleUserModel> list) {
      final idx = list.indexWhere((x) => x.user.id == e.userId);
      if (idx == -1) return list;
      final oldItem = list[idx];
      final newItem = oldItem.copyWith(isFollowed: !oldItem.isFollowed);
      toggled ??= newItem;
      final out = [...list]..[idx] = newItem;
      return out;
    }

    var newFollowing = toggle(state.following);
    var newSuggested = toggle(state.suggested);
    var newDiscover = toggle(state.discover);

    // wenn nirgendwo vorhanden -> raus
    if (toggled == null) return;

    final wasFollowed =
        !toggled!.isFollowed; // weil wir toggled bereits updated haben
    final shouldFollow = !wasFollowed;

    // UX wie Mockup: unfollow aus "Following" entfernen
    if (!shouldFollow) {
      newFollowing = newFollowing.where((x) => x.user.id != e.userId).toList();
    }

    emit(
      state.copyWith(
        following: newFollowing,
        suggested: newSuggested,
        discover: newDiscover,
      ),
    );

    try {
      if (shouldFollow) {
        await _repo.follow(e.userId);

        // wenn Follow aus Suggested/Discover -> in Following aufnehmen
        final exists = newFollowing.any((x) => x.user.id == e.userId);
        if (!exists) {
          emit(
            state.copyWith(
              following: [toggled!.copyWith(isFollowed: true), ...newFollowing],
            ),
          );
        }
      } else {
        await _repo.unfollow(e.userId);
      }
    } catch (_) {
      add(const CircleRefreshRequested()); // sauberer rollback
    }
  }
}
