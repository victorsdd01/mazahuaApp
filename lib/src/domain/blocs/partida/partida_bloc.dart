import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'partida_event.dart';
part 'partida_state.dart';

class PartidaBloc extends Bloc<PartidaEvent, PartidaState> {
  PartidaBloc() : super(const PartidaState()) {

    on<OnIsCorrectAnswerEvent>((event, emit) => emit(state.copyWith(isCorrectAnswer: true)));
    on<OnIsNotCorrectAnswerEvent>((event, emit) => emit(state.copyWith(isCorrectAnswer: false)));
    on<OnCurrentItemSelectedEvent>((event, emit) => emit(state.copyWith(selectedItem: event.selectedItem)));
    on<OnAddProgressIndicatorEvent>((event, emit) => emit(state.copyWith(progressIndicator: event.newValue)));
    on<OnChangeCurrentQuestionEvent>((event, emit) => emit(state.copyWith(currentQuestion: event.currentQuestion)));
    on<OnQuizCompleteEvent>((event, emit) => emit(state.copyWith(isQuizComplete: true)));
    on<OnNotQuizCompleteEvent>((event, emit) => emit(state.copyWith(isQuizComplete: false)));
    on<OnAddPuntosEvent>((event, emit) => emit(state.copyWith(puntosObtenidos: event.puntosObtenidos)));

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

  void changeCurrentQuestion(int currentQuestion) {
    add(OnChangeCurrentQuestionEvent(currentQuestion));
  }

  void quizComplete() {
    add(OnQuizCompleteEvent());
  }

  void quizNotComplete() {
    add(OnNotQuizCompleteEvent());
  }

  void sumarPuntosObtenidos(int puntosObtenidos) {
    add(OnAddPuntosEvent(puntosObtenidos));
  }

  
}
