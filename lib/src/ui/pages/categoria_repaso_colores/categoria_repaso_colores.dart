
// ignore_for_file: non_constant_identifier_names, deprecated_member_use

import 'package:mazahua/src/dataBase/data_base.dart';
import 'package:mazahua/src/ui/pages/pages.dart';

class CategoriaRepasoColores extends StatelessWidget {
   
  const CategoriaRepasoColores({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final String  NombreCategoria = ModalRoute.of(context)!.settings.arguments as String;

    return  Scaffold(
      body: Container(
       decoration: const BoxDecoration(
         image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/backgrounds/repaso_y_evaluar_background/repaso_y_evaluar.jpg'))
       ),
       height: size.height,
       width: size.width,
       child: FutureBuilder<List<Colores>>(
        future: MazahuaDataBase.instance.getAllColores(),
         builder: (BuildContext context, AsyncSnapshot<List<Colores>> snapshot) {
            if(snapshot.hasData){
              return Column(
                children: [
                  SizedBox(height: size.height *0.05),
                  Text(NombreCategoria,style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 30)),
                  _CardItem(
                    size: size,
                    colores: snapshot.data! ,
                  )
                ],
              );
            }else{
              return const Center(child: CircularProgressIndicator.adaptive());
            }
         },
       )
      ),
    );
  }
}

class _CardItem extends StatelessWidget {
  const _CardItem({
    Key? key,
    required this.size,
    required this.colores
  }) : super(key: key);

  final Size size;
  final List<Colores> colores;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.height *0.85,
      child: GridView.builder(
        itemCount: colores.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), 
        itemBuilder: (context, index){
          final color = colores[index];
          return GestureDetector(
            onTap: ()async{
              Soundpool pool = Soundpool(streamType: StreamType.notification);
                int soundId = await rootBundle.load(color.getAudio).then((ByteData soundData) {
                  return pool.load(soundData);
                });
              await pool.play(soundId);
            },
            child: Card(
              color: AppThemes.blanco.withOpacity(0.7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                    Image.asset(color.getImage, height: 90,),
                    Text(
                      color.nombre_es.toUpperCase(),
                      style: const TextStyle(
                        color: AppThemes.negro,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    Text(
                      color.nombre_maz.toUpperCase(),
                      style: const TextStyle(
                        color: AppThemes.negro,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}