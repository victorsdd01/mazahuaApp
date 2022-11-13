

import 'package:mazahua/src/ui/pages/pages.dart';

class TipoJuego{

  final int id;
  final String nombreJuego;
  final String tipoJuego;
  final String iconJuego;
  final String materia;

  TipoJuego({
    required this.id,
    required this.nombreJuego,
    required this.tipoJuego,
    required this.iconJuego,
    required this.materia,
  });


  factory TipoJuego.fromMap(Map<String,dynamic> data) => TipoJuego(

    id         : data['id_tipo_juego'], 
    nombreJuego: data['nombre_juego'], 
    tipoJuego  : data['tipo_juego'], 
    iconJuego  : data['imagen_juego'],
    materia    : data['materia_juego'] 
  );

  String get getIcon => 'assets/images/tipo_juego/$iconJuego';


  Color get getColor{
    
    if(materia == 'espanol'){
      return const Color.fromARGB(255, 252, 224, 138);
    }
    if(materia == 'matematicas'){
      return const Color.fromARGB(255, 163, 252, 179);
    }
    if(materia == 'ciencias'){
      return const Color.fromARGB(255, 150, 207, 252);
    }
    
    return Colors.white;
  }


}

enum Materias{
  espanol,
  matematicas,
  ciencias
}