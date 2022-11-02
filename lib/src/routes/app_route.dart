

import 'package:mazahua/src/ui/pages/pages.dart';


class AppRoutes{

  static const String  initialRoute = "home";

  static Map<String,Widget Function(BuildContext)> routes = {
    'home'                            : (_) =>  const HomePage(),
    'registrar'                       : (_) =>  const Registrar(),
    'login'                           : (_) =>  const LoginPage(),
    'repasoYevaluar'                  : (_) =>  const RepasoYevaluar(),
    'repaso'                          : (_) =>  const RepasoPage(),
    'jugar'                           : (_) =>  const JugarPage(),
    'categoriaRepasoAnimales'         : (_) =>  const CategoriaRepasoAnimales(),
    'categoriaRepasoNumeros'          : (_) =>  const CategoriaRepasoNumeros(),
    'categoriaRepasoFv'               : (_) =>  const CategoriaRepasoFv(),
    'categoriaRepasoColores'          : (_) =>  const CategoriaRepasoColores(),
    'categoriaRepasoPartesDelCuerpo'  : (_) =>  const CategoriaRepasoPdC(),
    'categoriaRepasoVocabulario'      : (_) =>  const CategoriaRepasoVocabulario(),
    'partidaPage'                     : (_) =>  const PartidaPage()     
  };


}