part of 'partida_bloc.dart';

abstract class PartidaEvent extends Equatable {
  const PartidaEvent();

  @override
  List<Object> get props => [];
}

class OnIsCorrectAnswerEvent extends PartidaEvent {}

class OnIsNotCorrectAnswerEvent extends PartidaEvent {}

class OnAddCurrenteIndex extends PartidaEvent {
  final int currentIndex;
  const OnAddCurrenteIndex(this.currentIndex);
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

class OnSubtracLifesEvent extends PartidaEvent{
  final int vidasDisponibles;
  const OnSubtracLifesEvent(this.vidasDisponibles);

}

class OnAddVidasEvent extends PartidaEvent{
  final int vidas;
  const OnAddVidasEvent(this.vidas);
}

class OnAddPreguntaAcertadaEvent extends PartidaEvent{
  final int nuevoValor;
  const OnAddPreguntaAcertadaEvent(this.nuevoValor);
}

class OnAddPreguntaFalladaEvent extends PartidaEvent{
  final int nuevoValor;
  const OnAddPreguntaFalladaEvent(this.nuevoValor);
}


class OnBackToHomeEvent extends PartidaEvent{}
class OnNotBackToHomeEvent extends PartidaEvent{}

class OnChangeGridViewEvent extends PartidaEvent{
  final int newValue;
  const OnChangeGridViewEvent(this.newValue);
}

class OnGriViewChangeEvent extends PartidaEvent{}
class OnGriViewNotChangeEvent extends PartidaEvent{}

class OnIsTypeAudioEvent extends PartidaEvent{}
class OnIsNotTypeAudioEvent extends PartidaEvent{}