

class NewUser{

  final String nombre;
  final String password;

  NewUser({
    required this.nombre,
    required this.password
  });


  String get name{
    return nombre; 
  }
  
  String get pass{
    return password;
  }

  Map<String,dynamic> toMap()=>{
    'nombre_usuario'  :nombre,
    'password_usuario':password
  };

}