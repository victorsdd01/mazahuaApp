

class Preguntas{

  final int id;
  final String pregunta;
  final String respCorrecta;
  final String respIncorrecta1;
  final String respIncorrecta2;
  final String respIncorrecta3;

  Preguntas({
    required this.id, 
    required this.pregunta, 
    required this.respCorrecta, 
    required this.respIncorrecta1, 
    required this.respIncorrecta2, 
    required this.respIncorrecta3
  });

  factory Preguntas.fromMap(Map<String,dynamic> data)=>
  Preguntas(
    id:              data['id_pregunta'], 
    pregunta:        data['pregunta'], 
    respCorrecta:    data['respuesta_correcta'], 
    respIncorrecta1: data['respuesta_incorrecta1'], 
    respIncorrecta2: data['respuesta_incorrecta2'], 
    respIncorrecta3: data['respuesta_incorrecta3']
  );

  String get respuestaCorrecta{
    return respCorrecta;
  }

   List<String> get posiblesRespuestas{
    List<String> opcions = [];
    opcions.addAll([respCorrecta,respIncorrecta1,respIncorrecta2,respIncorrecta3]);
    return opcions;
   }

}