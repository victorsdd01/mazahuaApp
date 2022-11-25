

class OperacionesMatematicas{

  final int id;
  final String tipoJuego;
  final String tipoOperacion;
  final String valorA;
  final String valorB;
  final String respCorrecta; // es un img
  final String respIncorrecta; // es img too

  OperacionesMatematicas({
      required this.id, 
      required this.tipoJuego, 
      required this.tipoOperacion, 
      required this.valorA, 
      required this.valorB, 
      required this.respCorrecta, 
      required this.respIncorrecta,
  });

  factory OperacionesMatematicas.fromMap(Map<String,dynamic> data)=> OperacionesMatematicas(
      id:             data['id_juegoMat'], 
      tipoJuego:      data['tipo_juego'], 
      tipoOperacion:  data['tipo_de_operacion'], 
      valorA:         data['valor_1'], 
      valorB:         data['valor_2'], 
      respCorrecta:   data['resp_correcta'], 
      respIncorrecta: data['resp_incorrecta']
  );

  String get respCorrectaImg => 'assets/images/numeros/$respCorrecta.png';


  String get pregunta{
    
    if(tipoOperacion == 'suma'){
      return '¿Cuanto es $valorA + $valorB';
    }

    if(tipoOperacion == 'resta'){
      return '¿Cuanto es $valorA - $valorB';
    }

    if(tipoOperacion == 'multiplicacion'){
      return '¿Cuanto es $valorA x $valorB';
    }

    if(tipoOperacion == 'division'){
      return '¿Cuanto es $valorA ÷ $valorB';
    }

    return 'pregunta ---> no data';
    
  }

  String get getRespCorrecta => respCorrecta+'.png';

  List<String> get posiblesRespuestas{
    List<String> opciones = [];
    opciones.addAll(['${respCorrecta.toLowerCase()}.png','${respIncorrecta.toLowerCase()}.png']);
    return opciones;
  }

}