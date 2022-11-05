part of 'partida_bloc.dart';

abstract class PartidaEvent extends Equatable {
  const PartidaEvent();

  @override
  List<Object> get props => [];
}

class OnIsCorrectAnswerEvent extends PartidaEvent {}

class OnIsNotCorrectAnswerEvent extends PartidaEvent {}

class OnCurrentItemSelectedEvent extends PartidaEvent {
  final int selectedItem;
  const OnCurrentItemSelectedEvent(this.selectedItem);
}

class OnAddProgressIndicatorEvent extends PartidaEvent {
  final double newValue;
  const OnAddProgressIndicatorEvent(this.newValue);
}

class OnChangeCurrentQuestionEvent extends PartidaEvent {
  final int currentQuestion;
  const OnChangeCurrentQuestionEvent(this.currentQuestion);
}

class OnQuizCompleteEvent extends PartidaEvent {}

class OnNotQuizCompleteEvent extends PartidaEvent {}

class OnAddPuntosEvent extends PartidaEvent {
  final int puntosObtenidos;
  const OnAddPuntosEvent(this.puntosObtenidos);

}
