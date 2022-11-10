
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazahua/src/dataBase/data_base.dart';
import 'package:mazahua/src/domain/blocs/blocs.dart';
import 'package:mazahua/src/ui/pages/pages.dart';

class PartidaPage extends StatelessWidget {
  const PartidaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final data = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
    final Niveles nivel = data['nivel'];
    final User    user  = data['user']; 

    final size = MediaQuery.of(context).size;
    final partidaBloc = BlocProvider.of<PartidaBloc>(context);
    final _pageController = PageController();

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          backgroundColor: AppThemes.quizColor,
          appBar: AppBar(
            actions: [ 
              BlocBuilder<PartidaBloc, PartidaState>(
                builder: (context, state){
                  if(nivel.nombreNivel == 'DIFICIL'){
                    if(state.vidas == 0 ) WidgetsBinding.instance.addPostFrameCallback((_) async => await MyAlerts.sinVidas(context, user)); 
                    
                    return state.vidas == 3 ? Row(
                      children: const [
                            Icon(Icons.favorite, color: AppThemes.rojo),
                            Icon(Icons.favorite, color: AppThemes.rojo),
                            Icon(Icons.favorite, color: AppThemes.rojo),
                        ]
                    ): state.vidas == 2 ? Row(
                      children: const [
                            Icon(Icons.favorite, color: AppThemes.rojo),
                            Icon(Icons.favorite, color: AppThemes.rojo),
                            Icon(Icons.favorite_outline_outlined, color: AppThemes.blanco),
                        ]
                    ): state.vidas == 1 ? Row(
                      children: const [
                            Icon(Icons.favorite, color: AppThemes.rojo),
                            Icon(Icons.favorite_outline_outlined, color: AppThemes.blanco),
                            Icon(Icons.favorite_outline_outlined, color: AppThemes.blanco),
                        ]
                    ): Row(
                      children: const [
                            Icon(Icons.favorite_outline_outlined, color: AppThemes.blanco),
                            Icon(Icons.favorite_outline_outlined, color: AppThemes.blanco),
                            Icon(Icons.favorite_outline_outlined, color: AppThemes.blanco),
                        ]
                    );
                  }else{
                    return const SizedBox();
                  }
                },
              )
            ],
            title: Text(nivel.nombreNivel),
            centerTitle: true,
            backgroundColor: AppThemes.quizColor,
            elevation: 0.0,
            leading: 
             IconButton(
              icon: const Icon(
                Icons.keyboard_arrow_left_rounded,
                color: AppThemes.blanco,
                size: 35,
              ),
              onPressed: () async {
                await MyAlerts.getOutQuiz(context, user);
              },
            ),
          ),
          body: FutureBuilder<List<Preguntas>>(
            future: MazahuaDataBase.instance.getPreguntas(),
            builder:(BuildContext context, AsyncSnapshot<List<Preguntas>> snapshot) {
              if (snapshot.hasData) {
                final List<Preguntas> pregu = snapshot.data!;
                pregu.shuffle();
                return BlocBuilder<PartidaBloc, PartidaState>(
                  builder: (context, state) {
                    if (state.isQuizComplete == true) {
                      final porcentajeObtenido = state.puntosObtenidos *100 / (snapshot.data!.length * 10) ;
                      return  Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: AppThemes.lightQuizColor
                              ),
                              margin: const EdgeInsets.all(10.0),
                              width: size.width,
                              height: size.height *0.60,
                              child: Column(
                                children: [
                                  SizedBox(height: size.height* 0.02,),
                                   const Text(
                                    'Felicidades!',
                                    style: TextStyle(
                                      color: AppThemes.blanco,
                                      fontSize: 40,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.italic
                                    ),
                                    
                                  ),
                                  Image.asset(
                                    'assets/images/quiz/winning.png',
                                    filterQuality: FilterQuality.high,
                                    height: size.height * 0.25,
                                    
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        const TextSpan(text: 'Obtuviste'),
                                        TextSpan(
                                          text: '${state.puntosObtenidos}',
                                          style:  TextStyle(
                                            color: porcentajeObtenido > 80 ? AppThemes.verde 
                                                 : porcentajeObtenido > 60 && porcentajeObtenido < 80 ? Colors.amber 
                                                 : porcentajeObtenido < 60 ? AppThemes.rojo 
                                                 : null,
                                          )
                                        ),
                                        const TextSpan(text: 'puntos',)
                                      ]
                                    ),
                                    style: const TextStyle(color: AppThemes.blanco,fontSize: 20),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    '$porcentajeObtenido %',
                                    style: TextStyle(
                                      fontSize: 60,
                                      color: 
                                      porcentajeObtenido > 80 ? AppThemes.verde 
                                      : porcentajeObtenido > 60 && porcentajeObtenido < 80 ? Colors.amber 
                                      : porcentajeObtenido < 60 ? AppThemes.rojo 
                                      : null,
                                      fontWeight: FontWeight.w300
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  const Text(
                                    'Completaste el Quiz de manera correcta!',
                                    style: TextStyle(
                                      color: AppThemes.blanco, fontSize: 20,
                                      fontWeight: FontWeight.w900
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 20),
                                   Text.rich(
                                    TextSpan(
                                      children: [
                                        //buenas
                                        const TextSpan(text: 'Obtuviste'),
                                        TextSpan(text: '${state.preguntasAcertadas}', style: const TextStyle(color: AppThemes.verde)),
                                        const TextSpan(text: 'buenas'),
                                        const TextSpan(text: 'y'),
                                        TextSpan(text: '${state.preguntasFallidas}' , style: const TextStyle(color: AppThemes.rojo)),
                                        const TextSpan(text: 'malas')

                                      ]
                                    ),
                                    style: const TextStyle(
                                      color: AppThemes.blanco, fontSize: 20,
                                      
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: size.height * 0.05,),
                            MyButtom(
                              textColor: Colors.white,
                              color: Colors.green,
                              text: 'Continuar',
                              borderRadius: 10.0,
                              onClick: () async{
                                partidaBloc.resetearEstados();
                                return await MyAlerts.finishQuiz(context, user);
                              }
                            ),
                          ],
                        )
                      );
                    } else {
                      return Column(
                        children: [
                          Text(
                            'Puntaje ${state.puntosObtenidos}',
                            style: const TextStyle(
                              fontSize: 15,
                              color: AppThemes.blanco,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.italic
                            ),
                          ),
                          SizedBox(height: size.height * 0.05),
                          Text(
                            '${state.currentQuestion}/${snapshot.data!.length}',
                            style: const TextStyle(
                                color: AppThemes.blanco, fontSize: 15),
                          ),
                          const _MyProgressBar(),
                          SizedBox(height: size.height * 0.08),
                          Expanded(
                            child: PageView.builder(
                              onPageChanged: (value) => partidaBloc.changeCurrentQuestion(value + 1),                 
                              physics: const NeverScrollableScrollPhysics(),
                              controller: _pageController,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                final Preguntas question      = pregu[index];
                                final List<String> respuestas = question.posiblesRespuestas;
                                final String respCorrecta     = question.posiblesRespuestas[0];
                                respuestas.shuffle();
                                return SizedBox(
                                  width: size.width * 0.80,
                                  //height: size.height *0.50,
                                  child: Column(
                                    children: [
                                      Text(
                                        question.pregunta, // pregunta.....
                                        style: const TextStyle(color: Colors.white, fontSize: 30),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: size.height * 0.05),
                                      Container(
                                          decoration: BoxDecoration(
                                            borderRadius:BorderRadius.circular(15.0),
                                          ),
                                          height: size.height * 0.30,
                                          width: size.width * 0.80,
                                          child: ListView.builder(
                                              physics:const NeverScrollableScrollPhysics(),
                                              itemCount: 4,
                                              itemBuilder: (context, index) {
                                                final selectedItem = state.currentIndex;
                                                final bool checked = index == selectedItem;
                                                return GestureDetector(
                                                    onTap: () {
                                                      partidaBloc.addCurrentIndex(index);
                                                      if (respuestas[index] == respCorrecta) {
                                                        
                                                        _pageController.nextPage(
                                                            duration: const Duration(milliseconds:400),
                                                            curve: Curves.ease
                                                        ).then((_) {
                                                            partidaBloc.addCurrentIndex(-1); // se reinicia el indice que esta en el estado cuando hace el next page
                                                            partidaBloc.sumarPuntosObtenidos(state.puntosObtenidos + 10);
                                                            partidaBloc.sumarPreguntaAcertada(state.preguntasAcertadas + 1);
                                                          }
                                                        );
                                                        ScaffoldMessenger.of(context)
                                                            .showSnackBar(
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
                                                              duration: const Duration(seconds: 2),
                                                              content: const Text(' +10 puntos'),
                                                              backgroundColor: AppThemes.verdeOscuro,
                                                            )
                                                        );                              
                                                        partidaBloc.addProgressIndicator(state.progressIndicator + 0.1);
                                                        if (state.currentQuestion == snapshot.data!.length) {
                                                          if (kDebugMode) {
                                                            print('🥵Estoy en la ultima pregunta');
                                                          }
                                                          partidaBloc.quizComplete();
                                                        }
                                                      }
                                                      if(respuestas[index]!= respCorrecta ){
                                                        partidaBloc.restarVidas(state.vidas-1);
                                                        _pageController.nextPage(
                                                            duration: const Duration(milliseconds:400),
                                                            curve: Curves.ease
                                                        ).then((_) {
                                                            partidaBloc.addCurrentIndex(-1); // se reinicia el indice que esta en el estado cuando hace el next page
                                                            partidaBloc.sumarPreguntaFallida(state.preguntasFallidas +1);
                                                          }
                                                        );
                                                        ScaffoldMessenger.of(context)
                                                            .showSnackBar(
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
                                                              duration: const Duration(seconds: 2),
                                                              content: const Text(' Incorrecto! :('),
                                                              backgroundColor: AppThemes.rojo,
                                                            )
                                                        );
                                                        partidaBloc.addProgressIndicator(state.progressIndicator + 0.1);
                                                        if (state.currentQuestion == snapshot.data!.length) {
                                                          if (kDebugMode) {
                                                            print('🥵Estoy en la ultima pregunta');
                                                          }
                                                          partidaBloc.quizComplete();
                                                        }
                                                      }
                                                    },
                                                    child: Container(
                                                      margin:const EdgeInsets.all( 10.0),
                                                      width: size.width * 0.70,
                                                      height: size.height * 0.05,
                                                      decoration: BoxDecoration(
                                                          color:  checked == true
                                                                  ? Colors.amber.shade600
                                                                  : AppThemes.lightQuizColor,
                                                          borderRadius:BorderRadius.circular(20.0)
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(top:15.0),
                                                        child: Text(
                                                          respuestas[index],
                                                          style: const TextStyle(
                                                              fontSize: 16,
                                                              color: AppThemes.blanco
                                                          ),
                                                          textAlign: TextAlign.center,   
                                                        ),
                                                      ),
                                                    )
                                                  );
                                              }
                                            )
                                          ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          MyButtom(
                              textColor: Colors.white,
                              color: Colors.green,
                              text: 'Siguiente',
                              borderRadius: 10.0,
                              onClick: () => null),
                          SizedBox(height: size.height * 0.05 )
                        ],
                      );
                    }
                  },
                );
              } else {
                return const Center(child: CircularProgressIndicator.adaptive());
              }
            },
          )
        ),
    );
  }
}

class _MyProgressBar extends StatelessWidget {
  const _MyProgressBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
      child: BlocBuilder<PartidaBloc, PartidaState>(
        builder: (context, state) {
          return LinearProgressIndicator(
            value: state.progressIndicator + 0.15,
            valueColor:  const AlwaysStoppedAnimation<Color>(Colors.amber),
            backgroundColor: Colors.amber[900],
            minHeight: 20,
          );
        },
      ),
    );
  }
}
