import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazahua/src/dataBase/data_base.dart';
import 'package:mazahua/src/domain/blocs/blocs.dart';
import 'package:mazahua/src/ui/pages/pages.dart';

class PartidaPage extends StatelessWidget {
  const PartidaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final Niveles nivel = ModalRoute.of(context)!.settings.arguments as Niveles;
    //final User user = ModalRoute.of(context)!.settings.arguments as User;
    final data = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
    final size = MediaQuery.of(context).size;
    final partidaBloc = BlocProvider.of<PartidaBloc>(context);
    final _pageController = PageController();

    //print('${data}');
    print('${data['user']}');

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          backgroundColor: Colors.indigo[300],
          appBar: AppBar(
            title: Text('${data['nivel']}'),
            centerTitle: true,
            backgroundColor: Colors.indigo[300],
            elevation: 0.0,
            leading: 
             IconButton(
              icon: const Icon(
                Icons.keyboard_arrow_left_rounded,
                color: AppThemes.blanco,
                size: 35,
              ),
              onPressed: () async {
                await MyAlerts.getOutQuiz(context);
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
                      return  Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Completaste el Quiz de manera correcta, Obtuviste: ${state.puntosObtenidos} puntos.',
                              style: const TextStyle(color: AppThemes.blanco, fontSize: 20,),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: size.height * 0.05,),
                            MyButtom(
                              textColor: Colors.white,
                              color: Colors.green,
                              text: 'Continuar',
                              borderRadius: 10.0,
                              onClick: () {
                                //TODO Aqui debo resetear los estados por si se va a jugar algun otro quiz.
                                
                                print('Aqui ya se inserto en la bd los puntos');
                                return Navigator.of(context).pushNamed('repasoYevaluar');
                              }
                            ),
                          ],
                        )
                      );
                    } else {
                      return Column(
                        children: [
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
                              onPageChanged: (value) {
                                partidaBloc.changeCurrentQuestion(value + 1);
                                //TODO Aqui se implemneta los puntos...
                              },
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
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 30),
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
                                                return GestureDetector(
                                                    onTap: () {
                                                      if (kDebugMode) {
                                                        print(
                                                            'current progress indicator--> ${state.progressIndicator}');
                                                      }
                                                      if (respuestas[index] == respCorrecta) {
                                                        _pageController.nextPage(
                                                            duration: const Duration(milliseconds:500),
                                                            curve: Curves.ease
                                                        ).then((_) => partidaBloc.sumarPuntosObtenidos(state.puntosObtenidos+10));
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
                                                              duration: const Duration(seconds: 1),
                                                              content: const Text('Correcto....... +10 puntoa'),
                                                              backgroundColor: AppThemes.verdeOscuro,
                                                            )
                                                        );
                                                        partidaBloc.currentSelectedItem(index);
                                                        partidaBloc.addProgressIndicator(state.progressIndicator +0.1);
                                                        if (state.currentQuestion == snapshot.data!.length) {
                                                          print('🥵Estoy en la ultima pregunta');
                                                          partidaBloc.quizComplete();
                                                          //TODO Aqui se debe implementar la logica para mostrar el puntaje obtenido
                                                        }
                                                      }
                                                    },
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      width: size.width * 0.70,
                                                      height: size.height * 0.05,
                                                      decoration: BoxDecoration(
                                                          color:state.selectedItem == index
                                                                  ? Colors.amber
                                                                  : Colors.indigo[200],
                                                          borderRadius:BorderRadius.circular(10.0)),
                                                      child: Text(
                                                        respuestas[index],
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            color:
                                                                AppThemes.blanco),
                                                        textAlign:
                                                            TextAlign.center,
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
                          SizedBox(
                            height: size.height * 0.05,
                          )
                        ],
                      );
                    }
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
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
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.indigo),
            backgroundColor: Colors.indigo[200],
            minHeight: 20,
          );
        },
      ),
    );
  }
}
