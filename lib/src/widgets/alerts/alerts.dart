

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazahua/src/domain/blocs/blocs.dart';
import 'package:mazahua/src/ui/pages/pages.dart';

class MyAlerts{

  static Future<void> getOutAlert(BuildContext context)async{
    final registroBloc    = BlocProvider.of<RegistroBloc>(context);
    final String nombre   = registroBloc.dataRegistro['nombre'];
    final String password = registroBloc.dataRegistro['password'];
    if(nombre.isNotEmpty && password.isNotEmpty){
       await showDialog(
        barrierDismissible: false,
        context: context, 
        builder: (_) =>  AlertDialog(
          title: const Text('¿Esta seguro que desea salir de la aplicacion?'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              MyButtom(
                textColor: AppThemes.blanco,
                color: AppThemes.rojo, 
                text: 'Cancelar', 
                borderRadius: 10.0, 
                onClick: () => Navigator.of(context).pop(false)
              ),
              const SizedBox(width: 20.0),
              MyButtom(
                textColor: AppThemes.blanco,
                color: AppThemes.verdeOscuro, 
                text: 'Aceptar', 
                borderRadius: 10.0, 
                onClick: ()=> Navigator.of(context).popAndPushNamed('home')
              )
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
        )
      );
    }else{
      Navigator.of(context).pushNamed('home');
    }



  }

    static Future<void>getOut(BuildContext context)async{
      await showDialog(
        barrierDismissible: false,
        context: context, 
        builder: (_) =>  AlertDialog(
          title: const Text('¿Esta seguro que desea cerrar la sesion?'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              MyButtom(
                textColor: AppThemes.blanco,
                color: AppThemes.rojo, 
                text: 'Cancelar', 
                borderRadius: 10.0, 
                onClick: () => Navigator.of(context).pop(false)
              ),
              const SizedBox(width: 20.0),
              MyButtom(
                textColor: AppThemes.blanco,
                color: AppThemes.verdeOscuro, 
                text: 'Aceptar', 
                borderRadius: 10.0, 
                onClick: ()=> Navigator.of(context).popAndPushNamed('home')
              )
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
        )
      );
    }


}