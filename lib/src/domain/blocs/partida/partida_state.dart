part of 'partida_bloc.dart';

class PartidaState extends Equatable {
  final bool isCorrectAnswer;

  const PartidaState({
     this.isCorrectAnswer = false
  });

  PartidaState copyWith({
    bool? isCorrectAnswer,
  })=> PartidaState(
    isCorrectAnswer: isCorrectAnswer ?? this.isCorrectAnswer
  );

  @override
  List<Object> get props => [isCorrectAnswer];
}
