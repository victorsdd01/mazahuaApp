part of 'juego_matematica_bloc.dart';

class JuegoMatematicaState extends Equatable {

  final int  preguntaActual;
  final bool correcto;
  final int indiceDelGridView;
  final int currentSelectedItem;
  final bool juegoTerminado;
  final int puntosObtenidos;
  final int cantBuenas;
  final int cantMalas;
  final int snapshotLenght;

  const JuegoMatematicaState({
    this.preguntaActual       = 1,
    this.correcto             = false,
    this.indiceDelGridView    = 0,
    this.currentSelectedItem  = -1,
    this.juegoTerminado       = false,
    this.puntosObtenidos      = 0,
    this.cantBuenas           = 0,
    this.cantMalas            = 0,
    this.snapshotLenght       = 0,
  });

  JuegoMatematicaState copyWith({
    int? preguntaActual,
    bool? correcto,
    int? indiceDelGridView,
    int? currentSelectedItem,
    bool? juegoTerminado,
    int? puntosObtenidos,
    int? cantBuenas,
    int? cantMalas,
    int? snapshotLenght,
  })=> JuegoMatematicaState(
    preguntaActual: preguntaActual ?? this.preguntaActual,
    correcto:  correcto ?? this.correcto,
    indiceDelGridView: indiceDelGridView ??  this.indiceDelGridView,
    currentSelectedItem: currentSelectedItem ?? this.currentSelectedItem,
    juegoTerminado: juegoTerminado ??  this.juegoTerminado,
    puntosObtenidos: puntosObtenidos ??  this.puntosObtenidos,
    cantBuenas: cantBuenas ?? this.cantBuenas,
    cantMalas: cantMalas ?? this.cantMalas,
    snapshotLenght: snapshotLenght ?? this.snapshotLenght,
  );
  
  @override
  List<Object> get props => [
    preguntaActual,
    correcto,
    indiceDelGridView,
    currentSelectedItem,
    juegoTerminado,
    puntosObtenidos,
    cantBuenas,
    cantMalas,
    snapshotLenght
  ];
}

