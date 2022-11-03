import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'partida_event.dart';
part 'partida_state.dart';

class PartidaBloc extends Bloc<PartidaEvent, PartidaState> {
  PartidaBloc() : super(const PartidaState()) {
    on<OnIsCorrectAnswerEvent>(
        (event, emit) => emit(state.copyWith(isCorrectAnswer: true)));
    on<OnIsNotCorrectAnswerEvent>(
        (event, emit) => emit(state.copyWith(isCorrectAnswer: false)));
    on<OnCurrentItemSelectedEvent>(
        (event, emit) => emit(state.copyWith(selectedItem: event.selectedItem)));
    on<OnAddProgressIndicatorEvent>(
        (event, emit) => emit(state.copyWith(progressIndicator: event.newValue)));
  }

  void isTheCorrectAnswer() {
    add(OnIsCorrectAnswerEvent());
  }

  void currentSelectedItem(int selectedItem) {
    add(OnCurrentItemSelectedEvent(selectedItem));
  }

  void addProgressIndicator(double value) {
    add(OnAddProgressIndicatorEvent(value));
  }
}
