import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazahua/src/domain/blocs/blocs.dart';
import 'package:mazahua/src/ui/pages/pages.dart';

class MyTextFormField extends StatelessWidget {
  final String labelText;
  final bool isInputForPassword;
  final Color? inputBorderColor;
  final bool registro;
  final bool login;
  const MyTextFormField(
      {
        Key? key, 
        required this.labelText, 
        required this.isInputForPassword,
        this.inputBorderColor,
        this.login = false,
        this.registro =  false
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final registerBloc = BlocProvider.of<RegistroBloc>(context);
    final loginBloc    = BlocProvider.of<LoginBloc>(context);
    return BlocBuilder<RegistroBloc, RegistroState>(
      builder: (context, state) {
        if(isInputForPassword){
          return SizedBox(
            width: size.width * 0.80,
            child: TextFormField(
              onChanged: (value) => registro == true ? registerBloc.dataRegistro['password'] = value
                                    : login == true ? loginBloc.loginData['password'] = value 
                                    : null,
              validator: (value){
                if(value!.isNotEmpty) return null;
                if(value.isEmpty) return 'Este campo es requerido';
                return null;
              },
              autofocus: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              obscureText : true,
              keyboardType: TextInputType.text,
              cursorColor : inputBorderColor ?? AppThemes.morado,
              decoration  : _inputDecoration(labelText, inputBorderColor ?? AppThemes.morado
              ),
            ),
          );
        }
        if(!isInputForPassword){
          return SizedBox(
            width: size.width * 0.80,
            child: TextFormField(
              onChanged: (value) =>  registro == true ? registerBloc.dataRegistro['nombre'] = value 
                                    : login   == true ? loginBloc.loginData['nombre'] = value
                                    : null, 

              validator: (value) {
                if(value!.isNotEmpty) return null;
                if(value.isEmpty)     return 'Este campo es requerido';
                return null;
              },
              focusNode: FocusNode(

              ),
              autofocus: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.name,
              cursorColor: inputBorderColor ?? AppThemes.morado,
              decoration: _inputDecoration(labelText, inputBorderColor ?? AppThemes.morado),
           ),
          );
        }
        return const Center(child: CircularProgressIndicator.adaptive(),);
      },
    );
  }
}

InputDecoration _inputDecoration(String labelText, Color inputBorderColor) {
  return InputDecoration(
      labelText: labelText,
      floatingLabelStyle:  TextStyle(color: inputBorderColor),
      floatingLabelAlignment: FloatingLabelAlignment.center,
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: AppThemes.disbaleColor)
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide:  BorderSide(
            color: inputBorderColor,
          )
      ),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: AppThemes.rojo,
          )
      ),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: AppThemes.rojo,
          )
      ),
  );
}
