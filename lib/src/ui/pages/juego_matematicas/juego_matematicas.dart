
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazahua/src/dataBase/data_base.dart';
import 'package:mazahua/src/domain/blocs/blocs.dart';
import 'package:mazahua/src/ui/pages/pages.dart';

class JuegoMatematicas extends StatelessWidget {
  const JuegoMatematicas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final pageController  =  PageController(keepPage: true);
    final mateBloc =  BlocProvider.of<JuegoMatematicaBloc>(context);
    final User user =  ModalRoute.of(context)!.settings.arguments as User;
    final size =  MediaQuery.of(context).size;
  
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: AppThemes.quizColor,
          automaticallyImplyLeading: false,
          title: BlocBuilder<JuegoMatematicaBloc, JuegoMatematicaState>(
            builder: (context, state) {
              return Text(
                           '${state.preguntaActual}/${state.snapshotLenght}', 
                           style: const TextStyle(
                             fontSize: 30, 
                             color: AppThemes.blanco
                           ),
              );
            },
          ),
          leading: IconButton(
            splashColor: AppThemes.transparente,
            onPressed: () async {
              await MyAlerts.getOutJuegoMate(context, user);
            }, 
            icon: const Icon(Icons.arrow_back_ios_outlined, color: AppThemes.blanco, size: 25,)
          ),
        ),
        body: FutureBuilder(
          future: MazahuaDataBase.instance.getOperacionesMatematicas(),
          builder: (BuildContext context, AsyncSnapshot<List<OperacionesMatematicas>> snapshot){
            if(snapshot.hasData){
              mateBloc.setSnapshotLenght(snapshot.data!.length);
              List<OperacionesMatematicas> operacionesMat = snapshot.data!..shuffle();
              return BlocBuilder<JuegoMatematicaBloc, JuegoMatematicaState>(
                builder: (context, state) {
                  if(state.juegoTerminado){
                    final double porcentaje = state.puntosObtenidos * 100  / 100;
                    return JuegoCompletado(
                      mateBloc: mateBloc,
                      user: user,
                      size: size, 
                      porcentajeObtenido: porcentaje, 
                      puntosObtenidos: state.puntosObtenidos
                    );
                  }
                  return Container(
                            color: AppThemes.quizColor,
                            width: size.width,
                            height: size.height,
                            child: PageView.builder(
                              onPageChanged: (_) => mateBloc.increasePregunta(),
                              controller: pageController,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: operacionesMat.length,
                              itemBuilder: (context, index){

                                final OperacionesMatematicas om = operacionesMat[index];
                                final posiblesRespuestas =  om.posiblesRespuestas;
                                print('shuffled: ${posiblesRespuestas..shuffle()}');
                                print('pr: $posiblesRespuestas');
                                //posiblesRespuestas.shuffle();

                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:  CrossAxisAlignment.center,
                                  children: [
                                    Text(om.pregunta, 
                                      style:  TextStyle(
                                        color: AppThemes.blanco,
                                        fontSize: size.width * 0.08,
                                      ),
                                    ),
                                    SizedBox(height: size.height * 0.05,),
                                    Container(
                                      padding: const EdgeInsets.only(left:10.0, right: 10.0),
                                      width: size.width,
                                      height:  size.height * 0.30 ,
                                      child: GridView.builder(
                                        itemCount: posiblesRespuestas.length,
                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 10.0 
                                        ), 
                                        itemBuilder: (context, index) {
                                          //final selectedItem =  state.currentSelectedItem;
                                          //final check = index == selectedItem;
                                          return  MyCard(
                                            width: 80,
                                            height: 10,
                                            borderRadius: 10.0,
                                            color:  AppThemes.lightQuizColor,
                                            image: 'assets/images/numeros/${posiblesRespuestas[index]}',
                                            onClick: () {
                                              mateBloc.addCurrentSelectedItem(index);

                                              if(state.preguntaActual ==  snapshot.data!.length){
                                                print('Estoy en la ultima pregunta 🥵');
                                                // TODO LLamar al evento de quiz completado
                                                mateBloc.juegoTerminado();
                                              }

                                              if(posiblesRespuestas[index] == om.getRespCorrecta){
                                                mateBloc.correcto();
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                    behavior:SnackBarBehavior.floating,
                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                                    margin: const EdgeInsets.only(
                                                        top: 10.0,
                                                        left: 10.0,
                                                        right: 10.0,
                                                        bottom: 120.0
                                                    ),
                                                    animation:const AlwaysStoppedAnimation(10.0),
                                                    dismissDirection:DismissDirection.horizontal,
                                                    duration: const Duration(milliseconds: 800),
                                                    content: const Text(' Correcto! +10'),
                                                    backgroundColor: AppThemes.verdeOscuro,
                                                  )
                                                );
                                                mateBloc.incrementarPuntosObtenidos();
                                                pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeOutCubic);
                                                //.then((_) => mateBloc.addCurrentSelectedItem(-1));
                                              }
                                              if(posiblesRespuestas[index] != om.getRespCorrecta){
                                                mateBloc.noCorrecto();
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                    behavior:SnackBarBehavior.floating,
                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                                    margin: const EdgeInsets.only(
                                                        top: 10.0,
                                                        left: 10.0,
                                                        right: 10.0,
                                                        bottom: 120.0
                                                    ),
                                                    animation:const AlwaysStoppedAnimation(10.0),
                                                    dismissDirection:DismissDirection.horizontal,
                                                    duration: const Duration(milliseconds: 900),
                                                    content: const Text('Incorrecto :( '),
                                                    backgroundColor: AppThemes.rojo,
                                                  )
                                                );
                                                pageController.nextPage(duration: const Duration(milliseconds: 800), curve: Curves.easeOutCubic);
                                                //.then((_) => mateBloc.addCurrentSelectedItem(-1));
                                              }
                                            }
                                          );
                                        }
                                      ),
                                    ),
                                    // MyButtom(
                                    //   textColor: AppThemes.blanco,
                                    //   color: AppThemes.verdeOscuro, 
                                    //   text: 'Siguiente',
                                    //   borderRadius: 10.0, 
                                    //   onClick: () {
                                        
                                    //   },
                                    // )
                                  ],
                                );
                              }
                            ),
                          );
                },
              );
            }else{
              return const Center(child: CircularProgressIndicator.adaptive(),);
            }
          }
        )
      ),
    );
  }
}

class JuegoCompletado extends StatelessWidget {
  const JuegoCompletado({
    Key? key,
    required this.size,
    required this.porcentajeObtenido,
    required this.puntosObtenidos,
    required this.user,
    required this.mateBloc
  }) : super(key: key);
  final Size size;
  final double porcentajeObtenido;
  final int puntosObtenidos;
  final User user;
  final JuegoMatematicaBloc mateBloc;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width  ,
      height: size.height ,
      decoration: const BoxDecoration(
        color: AppThemes.quizColor
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Felicidades!!', style: TextStyle(fontSize: 40, color: AppThemes.blanco, fontWeight: FontWeight.bold),),
          SizedBox(height: size.height * 0.05,),
          Image.asset('assets/images/quiz/winning.png'),
          SizedBox(height: size.height * 0.05,),
          RichText(
            text:TextSpan(
              children: [
                const  TextSpan(text: 'Obtuviste', style: TextStyle(fontSize: 25)),
                TextSpan(text: ' $puntosObtenidos', 
                  style: TextStyle(
                    color: puntosObtenidos <  60 ? AppThemes.rojo 
                         : puntosObtenidos >= 60 && porcentajeObtenido < 80?  Colors.amber
                         : puntosObtenidos >= 80 ? AppThemes.verdeOscuro
                         : null,
                    fontSize: 25
                  ),
                ),
                const TextSpan(text: ' Puntos', style: TextStyle(fontSize: 25))
              ]
            )
          ),
          SizedBox(height: size.height * 0.01,),
          RichText(
            text:TextSpan(
              children: [
                TextSpan(text: ' $porcentajeObtenido', 
                  style: TextStyle(
                    color: porcentajeObtenido <  60 ? AppThemes.rojo 
                         : porcentajeObtenido >= 60 && porcentajeObtenido < 80?  Colors.amber
                         : porcentajeObtenido >= 80 ? AppThemes.verdeOscuro
                         : null,
                    fontSize: 25
                  ),
                ),
                const TextSpan(text: ' %', style: TextStyle(fontSize: 25))
              ]
            )
          ),
          SizedBox(height: size.height * 0.01,),
          RichText(text:  TextSpan(
            children: [
              TextSpan(text: '${mateBloc.state.cantBuenas}', style: const TextStyle(color: AppThemes.verdeOscuro, fontSize: 25)),
              const TextSpan(text: ' buenas', style: TextStyle(fontSize: 25)),
              const TextSpan(text: ' y ', style: TextStyle(fontSize: 25)),
              TextSpan(text: '${mateBloc.state.cantMalas} ', style: const  TextStyle(color: AppThemes.rojo, fontSize: 25)),
              const TextSpan(text: 'malas', style: TextStyle(fontSize: 25))
            ]
          )),
          SizedBox(height: size.height * 0.10,),
           MyButtom(
             textColor: AppThemes.blanco,
             color: AppThemes.verdeOscuro, 
             text: 'Siguiente',
             borderRadius: 10.0, 
             onClick: () async {
               //context.select((JuegoMatematicaBloc bloc) => bloc.juegoNoTerminado());
               await MyAlerts.finishJuegoMatematicas(context, user);
               mateBloc.resetStates();
             },
           )

        ],
      ),
    );
  }
}