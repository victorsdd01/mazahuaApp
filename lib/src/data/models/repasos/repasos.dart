

// ignore_for_file: non_constant_identifier_names

class Animales{

   final int id;
   final String image;
   final String audio;
   final String nombre_es;
   final String nombre_maz;

   Animales({
     required this.id,
     required this.image,
     required this.audio,
     required this.nombre_es,
     required this.nombre_maz,
   });

   factory Animales.fromMap(Map<String,dynamic> data)
     => Animales(
      id: data['id_animal'], 
      image: data['url_image_animal'], 
      audio: data['url_sound_animal'], 
      nombre_es: data['nombre_an_esp'], 
      nombre_maz: data['nombre_an_mazahua'],
    );
   
   String get getAudio => 'assets/audios/audios_animales/$audio';
   String get getImage => 'assets/images/animales/$image'; 
 

}


 class Numeros{
   final int id; 
   final String image;
   final String audio;
   final String nombre_es;
   final String nombre_maz;
   Numeros({
    required this.id,
    required this.audio,
    required this.image,
    required this.nombre_es,
    required this.nombre_maz
   });

   factory Numeros.fromMap(Map<String,dynamic> data)
    => Numeros(
      id: data['id_numero'], 
      image: data['url_image_numero'], 
      audio: data['url_sound_numero'], 
      nombre_es: data['nombre_num_esp'], 
      nombre_maz: data['nombre_num_mazahua'],
    );

    String get getAudio => 'assets/audios/audios_numeros/$audio';
    String get getImage => 'assets/images/numeros/$image'; 


 }


 class FrutasYverduras{
   final int id; 
   final String image;
   final String audio;
   final String nombre_es;
   final String nombre_maz;
   FrutasYverduras({
    required this.id,
    required this.audio,
    required this.image,
    required this.nombre_es,
    required this.nombre_maz
   });

   factory FrutasYverduras.fromMap(Map<String,dynamic> data)
    => FrutasYverduras(
      id: data['id_fv'], 
      image: data['url_image_fv'], 
      audio: data['url_sound_fv'], 
      nombre_es: data['nombre_fv_esp'], 
      nombre_maz: data['nombre_fv_mazahua'],
    );

    String get getAudio => 'assets/audios/audios_fv/$audio';
    String get getImage => 'assets/images/fv/$image'; 
 }

 class Colores{

   final int id; 
   final String image;
   final String audio;
   final String nombre_es;
   final String nombre_maz;

   Colores({
    required this.id,
    required this.audio,
    required this.image,
    required this.nombre_es,
    required this.nombre_maz
   });

   factory Colores.fromMap(Map<String,dynamic> data) => Colores(

      id: data['id_color'], 
      audio: data['url_sound_color'], 
      image: data['url_image_color'],
      nombre_es: data['nombre_fv_esp'], 
      nombre_maz: data['nombre_fv_mazahua']
    );

    String get getAudio => 'assets/audios/audios_colores/$audio';
    String get getImage => 'assets/images/colores/$image';

 }

 class PartesDelCuerpo{

  final int id; 
   final String image;
   final String audio;
   final String nombre_es;
   final String nombre_maz;

   PartesDelCuerpo({
    required this.id,
    required this.audio,
    required this.image,
    required this.nombre_es,
    required this.nombre_maz
   });

   factory PartesDelCuerpo.fromMap(Map<String,dynamic> data) => PartesDelCuerpo(

      id: data['id_pdc'], 
      audio: data['url_sound_pdc'], 
      image: data['url_image_pdc'],
      nombre_es: data['nombre_fv_esp'], 
      nombre_maz: data['nombre_fv_mazahua']
    );

    String get getAudio => 'assets/audios/audios_pdc/$audio';
    String get getImage => 'assets/images/pdc/$image';

 }

 class Vocabulario{

  final int id; 
   final String image;
   final String audio;
   //final String nombre_es;
   final String nombre_maz;

   Vocabulario({
    required this.id,
    required this.audio,
    required this.image,
    //required this.nombre_es,
    required this.nombre_maz
   });

   factory Vocabulario.fromMap(Map<String,dynamic> data) => Vocabulario(

      id: data['id_vocabulario'], 
      audio: data['url_sound_voc'], 
      image: data['url_image_voc'],
      //nombre_es: data['nombre_fv_esp'], 
      nombre_maz: data['nombre_fv_mazahua']
    );

    String get getAudio => 'assets/audios/audios_vocabulario/$audio';
    String get getImage => 'assets/images/vocabulario/$image';

 }


