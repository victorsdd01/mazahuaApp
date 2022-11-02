
import 'package:mazahua/src/dataBase/data_base.dart';
import 'package:mazahua/src/ui/pages/pages.dart';

class RepasoPage extends StatelessWidget {
   
  const RepasoPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final MazahuaDataBase  mazahuaDataBase = MazahuaDataBase.instance;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/backgrounds/repaso_y_evaluar_background/repaso_y_evaluar.jpg')
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: size.height *0.80,
                width: size.width,
                child: FutureBuilder<List<Categoria>>(
                  future: mazahuaDataBase.getCategoriaDeRepasos(),
                  builder: (context, AsyncSnapshot<List<Categoria>>snapshot) {
                    if(snapshot.hasData){
                      final List<Categoria> repasos = snapshot.data!;
                      return GridView.builder(
                        itemCount: repasos.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2
                        ), 
                        itemBuilder: (context, index){
                          final Categoria categoria =  repasos[index];
                          return GestureDetector(
                            onTap: () {
                              switch (categoria.nombre) {
                                case 'Numeros':
                                  Navigator.of(context).pushNamed('categoriaRepasoNumeros', arguments: categoria.nombre);
                                  break;
                                case 'Animales':
                                  Navigator.of(context).pushNamed('categoriaRepasoAnimales', arguments: categoria.nombre);
                                  break;
                                case 'Frutas y verduras':
                                  Navigator.of(context).pushNamed('categoriaRepasoFv', arguments: categoria.nombre);
                                  break;
                                case 'Colores':
                                  Navigator.of(context).pushNamed('categoriaRepasoColores', arguments: categoria.nombre);
                                  break;
                                case 'Partes del cuerpo':
                                  Navigator.of(context).pushNamed('categoriaRepasoPartesDelCuerpo', arguments: categoria.nombre);
                                  break;
                                case 'Vocabulario general':
                                  Navigator.of(context).pushNamed('categoriaRepasoVocabulario', arguments: categoria.nombre);
                                  break;
                                default:
                              }
                            },
                            child: Card(
                              margin: const EdgeInsets.all(10.0),
                              color: AppThemes.blanco.withOpacity(0.7),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(categoria.getImage, height: 150,fit: BoxFit.cover,),
                                  Text(
                                    categoria.nombre,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      );
                    }else{
                      return const Center(child: CircularProgressIndicator.adaptive(),);
                    }
                  }
                ),
              ),
              MyButtom(
                    textColor: AppThemes.blanco,
                    color: AppThemes.disbaleColor, 
                    text: 'Regresar', 
                    borderRadius: 10.0, 
                    minWidth: 250,
                    onClick: ()=> Navigator.of(context).pop()
              )
            ],
          ),
        )
      ),
    );
  }

  
}