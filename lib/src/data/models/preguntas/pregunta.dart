// ignore_for_file: camel_case_types, unrelated_type_equality_checks


class Preguntas{

  final int id;
  final String pregunta;
  final String respCorrecta;
  final String respIncorrecta1;
  final String respIncorrecta2;
  final String respIncorrecta3;
  final String imgPregunta;
  final String audioPregunta;
  final String tipoDePregunta;
  final String categoriaPregunta;

  Preguntas({
    required this.id, 
    required this.pregunta, 
    required this.respCorrecta, 
    required this.respIncorrecta1, 
    required this.respIncorrecta2, 
    required this.respIncorrecta3,
    required this.imgPregunta,
    required this.audioPregunta,
    required this.tipoDePregunta,
    required this.categoriaPregunta,
  });

  factory Preguntas.fromMap(Map<String,dynamic> data)=>
  Preguntas(
    id:              data['id_pregunta'], 
    pregunta:        data['pregunta'], 
    respCorrecta:    data['respuesta_correcta'], 
    respIncorrecta1: data['respuesta_incorrecta1'], 
    respIncorrecta2: data['respuesta_incorrecta2'], 
    respIncorrecta3: data['respuesta_incorrecta3'],
    imgPregunta    : data['img_pregunta'],
    audioPregunta  : data['audio_pregunta'],
    tipoDePregunta : data['tipo_pregunta'],
    categoriaPregunta: data['categoria_pregunta'] 
  );

  String get getImgPregunta => 'assets/images/$imgPregunta';
  
  String get respuestaCorrecta{
    return respCorrecta;
  }

   List<String> get posiblesRespuestas{

    List<String> opcions = [];

    if(tipoDePregunta == 'normal'){
      // La pregunta es normal, las respuestas tambien
      opcions.addAll([respCorrecta,respIncorrecta1,respIncorrecta2,respIncorrecta3]);
       return opcions;
    }

    if(tipoDePregunta == 'imagen-normal'){
      // Si la pregunta es con imagen... las posibles respuestas seran con palabras
      opcions.addAll([respCorrecta,respIncorrecta1,respIncorrecta2,respIncorrecta3]);
       return opcions;
    }

    if(tipoDePregunta == 'audio'){
      // si la pregunta es con audio entonces la posibles respuestas seran imagenes
      opcions.addAll([respCorrecta.toLowerCase()+'.png',respIncorrecta1.toLowerCase()+'.png',respIncorrecta2.toLowerCase()+'.png',respIncorrecta3.toLowerCase()+'.png']);
       return opcions;
    }

    if(tipoDePregunta == 'normal-imagen'){
      // si la pregunta es normal-imagen entonces las posibles respuestas seran imagenes
      opcions.addAll([respCorrecta.toLowerCase()+'.png',respIncorrecta1.toLowerCase()+'.png',respIncorrecta2.toLowerCase()+'.png',respIncorrecta3.toLowerCase()+'.png']);
       return opcions;
    }

    if(tipoDePregunta == 'normal-audio'){
      // si la pregunta es normal-audio entonces las posibles respuestas seran audios
      opcions.addAll([respCorrecta.toLowerCase()+'.m4a',respIncorrecta1.toLowerCase()+'.m4a',respIncorrecta2.toLowerCase()+'.m4a',respIncorrecta3.toLowerCase()+'.m4a']);
       return opcions;
    }
      // opcions.addAll([respCorrecta.toLowerCase()+'.png',respIncorrecta1.toLowerCase()+'.png',respIncorrecta2.toLowerCase()+'.png',respIncorrecta3.toLowerCase()+'.png']);
    return opcions;

   }

}

