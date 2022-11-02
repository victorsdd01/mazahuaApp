part of 'registro_bloc.dart';

 class RegistroState extends Equatable {

  final bool isRegistred;

  const RegistroState({
    this.isRegistred =false,
  });

  RegistroState copyWith({
    bool? isRegistred,
  })=> RegistroState(
    isRegistred: isRegistred ??  this.isRegistred
  );
  
  @override
  List<Object> get props => [isRegistred];
}
