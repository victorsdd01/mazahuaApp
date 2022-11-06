part of 'partida_bloc.dart';

class PartidaState extends Equatable {

  
  final int currentIndex;
  final double progressIndicator;
  final int currentQuestion;
  final bool isQuizComplete;
  final int puntosObtenidos;
  final int vidas;
  final int preguntasAcertadas;
  final int preguntasFallidas;

  const PartidaState({
    
    this.currentIndex       = -1,
    this.progressIndicator  = 0.1,
    this.currentQuestion    = 1,
    this.isQuizComplete     = false,
    this.puntosObtenidos    = 0,
    this.vidas              = 3,
    this.preguntasAcertadas = 0,
    this.preguntasFallidas  = 0
  });

  PartidaState copyWith({

    
    int? currentIndex,
    double? progressIndicator,
    int? currentQuestion,
    bool? isQuizComplete,
    int? puntosObtenidos,
    int? vidas,
    int? preguntasAcertadas,
    int? preguntasFallidas,

  }) =>
      PartidaState(

          
          currentIndex: currentIndex ?? this.currentIndex,
          progressIndicator: progressIndicator ?? this.progressIndicator,
          currentQuestion: currentQuestion ?? this.currentQuestion,
          isQuizComplete: isQuizComplete ?? this.isQuizComplete,
          puntosObtenidos: puntosObtenidos ?? this.puntosObtenidos,
          vidas: vidas ?? this.vidas,
          preguntasAcertadas: preguntasAcertadas ?? this.preguntasAcertadas,
          preguntasFallidas: preguntasFallidas ?? this.preguntasFallidas

      );

  @override
  List<Object> get props => [

     
     currentIndex,
     progressIndicator,
     currentQuestion,
     isQuizComplete,
     puntosObtenidos,
     vidas,preguntasAcertadas,
     preguntasFallidas
     
  ];
}
