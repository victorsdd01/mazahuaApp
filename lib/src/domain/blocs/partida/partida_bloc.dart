import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'partida_event.dart';
part 'partida_state.dart';

class PartidaBloc extends Bloc<PartidaEvent, PartidaState> {
  PartidaBloc() : super(const PartidaState()) {

    on<OnAddCurrenteIndex>((event, emit) => emit(state.copyWith(currentIndex: event.currentIndex)));
    on<OnAddProgressIndicatorEvent>((event, emit) => emit(state.copyWith(progressIndicator: event.newValue)));
    on<OnChangeCurrentQuestionEvent>((event, emit) => emit(state.copyWith(currentQuestion: event.currentQuestion)));
    on<OnQuizCompleteEvent>((event, emit) => emit(state.copyWith(isQuizComplete: true)));
    on<OnNotQuizCompleteEvent>((event, emit) => emit(state.copyWith(isQuizComplete: false)));
    on<OnAddPuntosEvent>((event, emit) => emit(state.copyWith(puntosObtenidos: event.puntosObtenidos)));
    on<OnSubtracLifesEvent>((event, emit) => emit(state.copyWith(vidas: event.vidasDisponibles)));
    on<OnAddPreguntaAcertadaEvent>((event, emit) => emit(state.copyWith(preguntasAcertadas: event.nuevoValor)));
    on<OnAddPreguntaFalladaEvent>((event, emit) => emit(state.copyWith(preguntasFallidas: event.nuevoValor)));
    on<OnAddVidasEvent>((event, emit) => emit(state.copyWith(vidas: event.vidas)));
    on<OnBackToHomeEvent>((event, emit) => emit(state.copyWith(backToHome: true)));
    on<OnNotBackToHomeEvent>((event, emit) => emit(state.copyWith(backToHome: false)));
    on<OnChangeGridViewEvent>((event, emit) => emit(state.copyWith(crossAxisCount: event.newValue)));
    on<OnGriViewChangeEvent>((event, emit) => emit(state.copyWith(changeGridView: true)));
    on<OnGriViewNotChangeEvent>((event, emit) => emit(state.copyWith(changeGridView: false)));
    on<OnIsTypeAudioEvent>((event, emit) => emit(state.copyWith(isTypeAudio: true)));
    on<OnIsNotTypeAudioEvent>((event, emit) => emit(state.copyWith(isTypeAudio: false)));

  }

  void isTheCorrectAnswer() {
    add(OnIsCorrectAnswerEvent());
  }

  void addCurrentIndex(int currentIndex) {
    add(OnAddCurrenteIndex(currentIndex));
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


  void resetearEstados(){
    // progress indicator
    // currentQuestion
    // isQuizCompete
    // puntos obtenidos
    add(OnNotQuizCompleteEvent());
    add(const OnChangeCurrentQuestionEvent(1));
    add(const OnAddProgressIndicatorEvent(0.1));
    add(const OnAddPuntosEvent(0));
    add(const OnAddPreguntaAcertadaEvent(0));
    add(const OnAddPreguntaFalladaEvent(0));
    add(const OnAddVidasEvent(3));

  }

  void restarVidas(int vidasDisponibles){
    add(OnSubtracLifesEvent(vidasDisponibles));
  }

  void sumarPreguntaAcertada(int nuevoValor){
    add(OnAddPreguntaAcertadaEvent(nuevoValor));
  }

  void sumarPreguntaFallida(int nuevoValor){
    add(OnAddPreguntaFalladaEvent(nuevoValor));
  }

  void cambiarVistDelGrid(int newValue){
    add(OnChangeGridViewEvent(newValue));
  }

  void isTyperAudio(){
    add(OnIsTypeAudioEvent());
  }
  void isNotTyperAudio(){
    add(OnIsNotTypeAudioEvent());
  }
  
}
