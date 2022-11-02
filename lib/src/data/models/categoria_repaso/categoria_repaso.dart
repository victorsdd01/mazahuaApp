

class Categoria{
  

  final int id;
  final String nombre;
  final String urlImagen;

  Categoria({
    required this.id,
    required this.nombre,
    required this.urlImagen
  });

  String get getImage => 'assets/images/repasos/$urlImagen';

  factory Categoria.fromMap(Map<String,dynamic> data) =>
     Categoria(
       id: data['id_categoria'], 
       nombre: data['nombre_categoria'], 
       urlImagen: data['url_image_categoria']
    );
}