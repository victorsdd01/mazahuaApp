part of 'juego_matematica_bloc.dart';

abstract class JuegoMatematicaEvent extends Equatable {
  const JuegoMatematicaEvent();

  @override
  List<Object> get props => [];
}

class OnIncrementPreguntaActualEvent extends JuegoMatematicaEvent{
  final int newValue;
  const OnIncrementPreguntaActualEvent(this.newValue);
}

class OnCorrectoEvent extends JuegoMatematicaEvent{}
class OnNoCorrectoEvent extends JuegoMatematicaEvent{}


class OnIndiceActualDelGridViewEvent extends JuegoMatematicaEvent{
  final int newValue;
  const OnIndiceActualDelGridViewEvent(this.newValue);
}

class OnAddCurrentSelectedItemEvent extends JuegoMatematicaEvent{
  final int selectedItem;
  const OnAddCurrentSelectedItemEvent(this.selectedItem);
}

class OnJuegoTerminadoEvent extends JuegoMatematicaEvent{}
class OnJuegoNoTerminadoEvent extends JuegoMatematicaEvent{}


class OnIncrementarPuntosObtenidosEvent extends JuegoMatematicaEvent{
  final int newValue;
  const OnIncrementarPuntosObtenidosEvent(this.newValue);
}

class OnAddCantidadBuenasEvent extends JuegoMatematicaEvent{
  final int newValue;
  const OnAddCantidadBuenasEvent(this.newValue);

}

class OnAddCantidadMalasEvent extends JuegoMatematicaEvent{
  final int newValue;
  const OnAddCantidadMalasEvent(this.newValue);
}

class OnAddSnapshotLenghtEvent extends JuegoMatematicaEvent{
  final int newValue;
  const OnAddSnapshotLenghtEvent(this.newValue);
}
