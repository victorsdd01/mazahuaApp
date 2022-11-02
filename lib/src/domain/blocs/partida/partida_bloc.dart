import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'partida_event.dart';
part 'partida_state.dart';

class PartidaBloc extends Bloc<PartidaEvent, PartidaState> {
  PartidaBloc() : super(const PartidaState()) {
    on<OnIsCorrectAnswerEvent>(
        (event, emit) => state.copyWith(isCorrectAnswer: true));
    on<OnIsNotCorrectAnswerEvent>(
        (event, emit) => state.copyWith(isCorrectAnswer: false));
  }

  void isTheCorrectAnswer(){
     add(OnIsCorrectAnswerEvent());
  }
}
