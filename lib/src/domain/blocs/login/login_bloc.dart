import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Map<String,dynamic>loginData = {
    'nombre'  :'',
    'password':''
  }; 

  LoginBloc() : super(LoginInitial()) {
    on((event, emit) => null);
  }

}
