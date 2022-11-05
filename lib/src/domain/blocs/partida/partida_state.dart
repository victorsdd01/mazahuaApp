part of 'partida_bloc.dart';

class PartidaState extends Equatable {

  final bool isCorrectAnswer;
  final int selectedItem;
  final double progressIndicator;
  final int currentQuestion;
  final bool isQuizComplete;
  final int puntosObtenidos;

  const PartidaState({
    this.isCorrectAnswer   = false,
    this.selectedItem      = -1,
    this.progressIndicator = 0.1,
    this.currentQuestion   = 1,
    this.isQuizComplete    = false,
    this.puntosObtenidos   = 0,
  });

  PartidaState copyWith({

    bool? isCorrectAnswer,
    int? selectedItem,
    double? progressIndicator,
    int? currentQuestion,
    bool? isQuizComplete,
    int? puntosObtenidos

  }) =>
      PartidaState(

          isCorrectAnswer: isCorrectAnswer ?? this.isCorrectAnswer,
          selectedItem: selectedItem ?? this.selectedItem,
          progressIndicator: progressIndicator ?? this.progressIndicator,
          currentQuestion: currentQuestion ?? this.currentQuestion,
          isQuizComplete: isQuizComplete ?? this.isQuizComplete,
          puntosObtenidos: puntosObtenidos ?? this.puntosObtenidos

      );

  @override
  List<Object> get props => [

     isCorrectAnswer,
     selectedItem,
     progressIndicator,
     currentQuestion,
     isQuizComplete,
     puntosObtenidos
     
  ];
}
