import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazahua/src/dataBase/data_base.dart';
import 'package:mazahua/src/domain/blocs/blocs.dart';
import 'package:mazahua/src/ui/pages/pages.dart';

class PartidaPage extends StatelessWidget {
  const PartidaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Niveles nivel = ModalRoute.of(context)!.settings.arguments as Niveles;
    final size = MediaQuery.of(context).size;
    final partidaBloc = BlocProvider.of<PartidaBloc>(context);
    final _pageController = PageController();
    
    return Scaffold(
        backgroundColor: Colors.indigo[300],
        appBar: AppBar(
          title: Text(nivel.nombreNivel),
          centerTitle: true,
          backgroundColor: Colors.indigo[300],
          elevation: 0.0,
        ),
        body: FutureBuilder<List<Preguntas>>(
          future: MazahuaDataBase.instance.getPreguntas(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Preguntas>> snapshot) {
            if (snapshot.hasData) {
              final List<Preguntas> pregu = snapshot.data!;
              pregu.shuffle();
              return BlocBuilder<PartidaBloc, PartidaState>(
                builder: (context, state) {
                  return Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      const _MyProgressBar(),
                      //Text('1/${snapshot.data!.length}'),
                      SizedBox(
                        height: size.height * 0.08,
                      ),
                      Expanded(
                        child: PageView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: _pageController,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            final Preguntas question = pregu[index];
                            final List<String> respuestas =
                                question.posiblesRespuestas;
                            final String respCorrecta =
                                question.posiblesRespuestas[0];
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
                                  SizedBox(
                                    height: size.height * 0.05,
                                  ),
                                  Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        //color: Colors.indigo[600],
                                      ),
                                      height: size.height * 0.30,
                                      width: size.width * 0.80,
                                      child: ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: 4,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                                onTap: () {
                                                  if (kDebugMode) {
                                                    print(
                                                        'current progress indicator--> ${state.progressIndicator}');
                                                  }
                                                  if (respuestas[index] ==
                                                      respCorrecta) {
                                                    if (kDebugMode) {
                                                      print('resp correcta');
                                                    }
                                                    _pageController.nextPage(
                                                        duration:
                                                            const Duration(
                                                                seconds: 2),
                                                        curve: Curves.ease);
                                                    partidaBloc
                                                        .addProgressIndicator(
                                                            state.progressIndicator +
                                                                0.1);
                                                    //TODO Aqui va la insercion a la BD...
                                                  }
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets.all(
                                                      10.0),
                                                  width: size.width * 0.70,
                                                  height: size.height * 0.05,
                                                  decoration: BoxDecoration(
                                                      //color: Colors.indigo[200],
                                                      color:
                                                          state.selectedItem ==
                                                                  index
                                                              ? Colors.amber
                                                              : Colors
                                                                  .indigo[200],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0)),
                                                  child: Text(
                                                    respuestas[index],
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        color:
                                                            AppThemes.blanco),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ));
                                          })),
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
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
          },
        ));
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
            value: state.progressIndicator,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.indigo),
            backgroundColor: Colors.indigo[200],
            minHeight: 20,
          );
        },
      ),
    );
  }
}
