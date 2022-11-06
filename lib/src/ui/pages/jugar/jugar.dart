

import 'package:mazahua/src/dataBase/data_base.dart';
import 'package:mazahua/src/ui/pages/pages.dart';

class JugarPage extends StatelessWidget {
   
  const JugarPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    
    final size      = MediaQuery.of(context).size;
    final User user = ModalRoute.of(context)!.settings.arguments as User;
    return  WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.only(top:size.height*0.06),
                child: const Text('Seleccione un nivel', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),),
              ),
              SizedBox(
                width: size.width * 0.40,
                height: size.height *0.40,
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
                            onClick: ()=> Navigator.pushNamed(context, 'partidaPage',arguments: {
                                'nivel':nivel,
                                'user' :user
                              }
                            ),
                            textColor: AppThemes.blanco,
                          );
                        },
                      );
                    }else{
                      return const Center(child: CircularProgressIndicator.adaptive(),);
                    }
      
                  }
                ),
              ),
              MyButtom(
                textColor: AppThemes.blanco,
                color: AppThemes.morado, 
                text: 'Regresar', 
                borderRadius: 10.0, 
                onClick: ()=> Navigator.of(context).pushNamed('repasoYevaluar',arguments: user)
              )
            ],
          ),
        )
      ),
    );
  }
}