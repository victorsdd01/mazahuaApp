

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

    static Future<void>getOutQuiz(BuildContext context, User user)async{
      await showDialog(
        barrierDismissible: false,
        context: context, 
        builder: (_) =>  AlertDialog(
          title: const Text('¿Esta seguro que desea salir del quiz? perderá todos sus puntos obtenidos.'),
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
                onClick: () {
                  final PartidaBloc partidaBloc = BlocProvider.of<PartidaBloc>(context);
                  partidaBloc.resetearEstados();
                  return Navigator.of(context).popAndPushNamed('jugar', arguments: user);
                }
              )
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
        )
      );
    }


    static Future<void>finishQuiz(BuildContext context, User user)async{
      await showDialog(
        barrierDismissible: false,
        context: context, 
        builder: (_) =>  AlertDialog(
          title: const Text('¿Desea iniciar otra partida de quiz o desea ir al menu de repaso y evaluar?'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              MyButtom(
                textColor: AppThemes.blanco,
                color: AppThemes.rojo, 
                text: 'Ir a repaso y evaluar', 
                borderRadius: 10.0, 
                onClick: () => Navigator.of(context).popAndPushNamed('repasoYevaluar', arguments: user)
              ),
              const SizedBox(width: 20.0),
              MyButtom(
                textColor: AppThemes.blanco,
                color: AppThemes.verdeOscuro, 
                text: 'Otra partida', 
                borderRadius: 10.0, 
                onClick: ()=> Navigator.of(context).popAndPushNamed('jugar', arguments: user)
              )
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
        )
      );
    }


    static Future<void>sinVidas(BuildContext context, User user)async{
      await showDialog(
        barrierDismissible: true,
        context: context, 
        builder: (_) =>  AlertDialog(
          title: const Text('Has perdido todos tus intentos, te recomendamos repasar otra vez, no te preocupes siempre puedes intentarlo!'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              MyButtom(
                textColor: AppThemes.blanco,
                color: AppThemes.rojo, 
                text: 'Ir a repaso', 
                borderRadius: 10.0, 
                onClick: () => Navigator.of(context).popAndPushNamed('repaso')
              ),
              const SizedBox(width: 20.0),
              MyButtom(
                textColor: AppThemes.blanco,
                color: AppThemes.verdeOscuro, 
                text: 'Aceptar', 
                borderRadius: 10.0, 
                onClick: () {
                  final PartidaBloc partidaBloc = BlocProvider.of<PartidaBloc>(context);
                  partidaBloc.resetearEstados();
                  return Navigator.of(context).popAndPushNamed('repasoYevaluar', arguments: user);
                }
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