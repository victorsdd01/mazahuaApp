

class Niveles{


  final int id;
  final String nombreNivel;

  Niveles({
    required this.id,
    required this.nombreNivel
  });

  factory Niveles.fromMap(Map<String,dynamic> data) => Niveles(
      id: data['id_nivel'], 
      nombreNivel: data['nombre_nivel']
  );
}