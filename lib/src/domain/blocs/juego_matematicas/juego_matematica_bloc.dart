import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mazahua/src/domain/blocs/partida/partida_bloc.dart';



part 'juego_matematica_event.dart';
part 'juego_matematica_state.dart';

class JuegoMatematicaBloc extends Bloc<JuegoMatematicaEvent, JuegoMatematicaState> {



    JuegoMatematicaBloc() : super(const JuegoMatematicaState()) {
    on<OnIncrementPreguntaActualEvent>((event, emit) => emit(state.copyWith(preguntaActual: event.newValue)));
    on<OnCorrectoEvent>((event, emit) => emit(state.copyWith(correcto: true)));
    on<OnNoCorrectoEvent>((event, emit) => emit(state.copyWith(correcto: false)));
    on<OnIndiceActualDelGridViewEvent>((event, emit) => emit(state.copyWith(indiceDelGridView: event.newValue)));
    on<OnAddCurrentSelectedItemEvent>((event, emit) => emit(state.copyWith(currentSelectedItem: event.selectedItem)));
    on<OnJuegoTerminadoEvent>((event, emit) => emit(state.copyWith(juegoTerminado: true)));
    on<OnJuegoNoTerminadoEvent>((event, emit) => emit(state.copyWith(juegoTerminado: false)));
    on<OnIncrementarPuntosObtenidosEvent>((event, emit) => emit(state.copyWith(puntosObtenidos: event.newValue)));
    on<OnAddCantidadBuenasEvent>((event, emit) => emit(state.copyWith(cantBuenas: event.newValue)));
    on<OnAddCantidadMalasEvent>((event, emit) => emit(state.copyWith(cantMalas: event.newValue)));
    on<OnAddSnapshotLenghtEvent>((event, emit) => emit(state.copyWith(snapshotLenght: event.newValue)));
  }


  void increasePregunta(){
    add(OnIncrementPreguntaActualEvent(state.preguntaActual+1));
  }
  
  void correcto(){
    add(OnCorrectoEvent());
    add(OnAddCantidadBuenasEvent(state.cantBuenas + 1));
  }
  
  void noCorrecto(){
    add(OnNoCorrectoEvent());
    add(OnAddCantidadMalasEvent(state.cantMalas + 1));
  }

  void indiceDelGridView(int index){
    add(OnIndiceActualDelGridViewEvent(index));
  }

  void addCurrentSelectedItem(int index){
    add(OnAddCurrentSelectedItemEvent(index));
  }

  void juegoTerminado(){
    add(OnJuegoTerminadoEvent());
  }

  void juegoNoTerminado(){
    add(OnJuegoNoTerminadoEvent());
  }

  void incrementarPuntosObtenidos(){
    add(OnIncrementarPuntosObtenidosEvent(state.puntosObtenidos + 25));
  }
  
  void setSnapshotLenght(int snapShotLenght){
    add(OnAddSnapshotLenghtEvent(snapShotLenght));
  }


  void resetStates(){

    add(OnJuegoNoTerminadoEvent());
    add(const OnIncrementarPuntosObtenidosEvent(0));
    add(const OnAddCantidadBuenasEvent(0));
    add(const OnAddCantidadMalasEvent(0));
    add(const OnIncrementPreguntaActualEvent(1));
  }

}
