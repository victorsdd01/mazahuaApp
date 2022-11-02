

import 'package:mazahua/src/dataBase/data_base.dart';
import 'package:mazahua/src/ui/pages/pages.dart';

class JugarPage extends StatelessWidget {
   
  const JugarPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return  Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/backgrounds/repaso_y_evaluar_background/repaso_y_evaluar.jpg')
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(top:size.height*0.06),
              child: const Text('Seleccione un nivel', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),),
            ),
            SizedBox(
              width: size.width * 0.40,
              height: size.height *0.60,
              child: FutureBuilder<List<Niveles>>(
                future: MazahuaDataBase.instance.getNiveles() ,
                builder: (context, AsyncSnapshot<List<Niveles>> snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_,index){
                        final Niveles nivel = snapshot.data![index];
                        return MyButtom(
                          height: size.height * 0.05,
                          color: AppThemes.morado, 
                          text: nivel.nombreNivel, 
                          borderRadius: 10.0, 
                          onClick: ()=> Navigator.pushNamed(context, 'partidaPage', arguments: nivel),
                          textColor: AppThemes.blanco,
                        );
                      },
                    );
                  }else{
                    return const Center(child: CircularProgressIndicator.adaptive(),);
                  }
    
                }
              ),
            )
          ],
        ),
      )
    );
  }
}