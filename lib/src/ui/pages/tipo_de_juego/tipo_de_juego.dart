

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazahua/src/dataBase/data_base.dart';
import 'package:mazahua/src/domain/blocs/blocs.dart';
import 'package:mazahua/src/ui/pages/pages.dart';

class SeleccionarJuegoPage extends StatelessWidget {
  const SeleccionarJuegoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final User user = ModalRoute.of(context)!.settings.arguments as User;
    final size = MediaQuery.of(context).size;
    final partidaBloc = BlocProvider.of<PartidaBloc>(context);


    return  WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: _MyAppBar(context, partidaBloc, user),
        body: Container(
          //color: AppThemes.lightQuizColor,
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          height: size.height,
          width: size.width,
          child: FutureBuilder(
            future: MazahuaDataBase.instance.getTiposDeJuegos(),
            builder: (BuildContext context, AsyncSnapshot<List<TipoJuego>> snapshot) { 
             if(snapshot.hasData){
                return BlocBuilder<PartidaBloc, PartidaState>(
                  builder: (context, state) {
                    return GridView.builder(
                      itemCount: snapshot.data!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: state.crossAxisCount,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0
                      ), 
                      itemBuilder: (context, index){
                        final  TipoJuego juegos = snapshot.data![index];
                        return  GestureDetector(
                          onTap: (){
                            switch (juegos.materia) {
                              case 'espanol':
                                Navigator.pushNamed(context, 'jugar', arguments: user);
                                break;
                              default:
                            }
                          },
                          child: Card(
                            color: juegos.getColor,
                            elevation: 2.5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(juegos.getIcon, fit: BoxFit.cover, height: size.height*0.15,),
                                Text(juegos.nombreJuego, textAlign: TextAlign.center,),
                              ],
                            ),
                          ),
                        );
                      }
                    );
                  },
                );
             }else{
               return const Center(child: CircularProgressIndicator.adaptive(),);
             }
            },
          ),
        ),
      ),
    );
  }

  AppBar _MyAppBar(BuildContext context, PartidaBloc partidaBloc, User user) {
    return AppBar(
      actions:[ 
          BlocBuilder<PartidaBloc, PartidaState>(
            builder: (context, state) {
              
              return IconButton(
                splashColor: AppThemes.transparente,
                splashRadius: 0.1,
                onPressed: (){
                  partidaBloc.add(OnGriViewChangeEvent());
                    state.crossAxisCount == 3 ? partidaBloc.add(const OnChangeGridViewEvent(2)) 
                  : state.crossAxisCount == 2 ? partidaBloc.add(const OnChangeGridViewEvent(1))
                  : partidaBloc.add(const OnChangeGridViewEvent(3));
                  if(state.changeGridView){
                    partidaBloc.add(OnGriViewNotChangeEvent()); 
                  }
                },
                icon: state.changeGridView == true? const Icon(Icons.apps_outlined, color: AppThemes.lightQuizColor,)
                    : const Icon(Icons.apps_outlined)
              );
            },
          )
        ],
        leading: BlocBuilder<PartidaBloc, PartidaState>(
          builder: (context, state) {
            if(state.backToHome) {
              partidaBloc.add(OnNotBackToHomeEvent());
            }
            return IconButton(
               onPressed: (){
                 partidaBloc.add(OnBackToHomeEvent());// true
                 Navigator.pushNamed(context, 'repasoYevaluar', arguments: user);
               }, 
               icon: state.backToHome == true ? const Icon(Icons.home,color: AppThemes.lightQuizColor, size: 35,) : const Icon(Icons.home_outlined, size: 35,)
            );
          },
        ),
        backgroundColor: AppThemes.skyColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0))
        ),
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: const Text('Seleccione el tipo de juego',style: TextStyle(color: AppThemes.lightQuizColor),),
        centerTitle: true,
      );
  }
  
}