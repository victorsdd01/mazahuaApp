import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mazahua/src/data/models/new_user/new_user.dart';
import 'package:mazahua/src/dataBase/data_base.dart';

part 'registro_event.dart';
part 'registro_state.dart';

class RegistroBloc extends Bloc<RegistroEvent, RegistroState> {

 final Map<String, dynamic> dataRegistro = {
   'nombre'  :'',
   'password':''
 };

  RegistroBloc() : super(const RegistroState()) {
    on<OnIsRegistredEvent>((event, emit) => emit(state.copyWith(isRegistred: true)));
    on<OnIsNotRegistredEvent>((event, emit) => emit(state.copyWith(isRegistred: false)));
  }

  Future<void> insertNewUser(NewUser user) async {
    MazahuaDataBase.instance.insertNewUser(user);
  }
}
