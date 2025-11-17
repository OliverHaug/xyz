import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xyz/features/main/logic/main_event.dart';
import 'package:xyz/features/main/logic/main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(const MainState()) {
    on<MainTabChanged>(
      (e, emit) => emit(state.copyWith(currentIndex: e.index)),
    );
  }
}
