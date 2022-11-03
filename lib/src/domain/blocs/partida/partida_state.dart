part of 'partida_bloc.dart';

class PartidaState extends Equatable {
  final bool isCorrectAnswer;
  final int selectedItem;
  final double progressIndicator;

  const PartidaState({
    this.isCorrectAnswer = false,
    this.selectedItem = -1,
    this.progressIndicator = 0.1
  });

  PartidaState copyWith({
    bool? isCorrectAnswer,
    int? selectedItem,
    double? progressIndicator,
  }) =>
      PartidaState(
          isCorrectAnswer: isCorrectAnswer ?? this.isCorrectAnswer,
          selectedItem: selectedItem ?? this.selectedItem,
          progressIndicator: progressIndicator ?? this.progressIndicator,
      );

  @override
  List<Object> get props => [isCorrectAnswer, selectedItem,progressIndicator];
}
