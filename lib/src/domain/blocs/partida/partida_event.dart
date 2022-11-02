part of 'partida_bloc.dart';

abstract class PartidaEvent extends Equatable {
  const PartidaEvent();

  @override
  List<Object> get props => [];
}


class OnIsCorrectAnswerEvent extends PartidaEvent{}
class OnIsNotCorrectAnswerEvent extends PartidaEvent{}
