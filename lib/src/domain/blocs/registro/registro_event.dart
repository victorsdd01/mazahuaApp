part of 'registro_bloc.dart';

abstract class RegistroEvent extends Equatable {
  const RegistroEvent();

  @override
  List<Object> get props => [];
}

class OnIsRegistredEvent extends RegistroEvent{}
class OnIsNotRegistredEvent extends RegistroEvent{}
