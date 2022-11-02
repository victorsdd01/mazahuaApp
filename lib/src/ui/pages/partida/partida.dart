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
              late Preguntas p;
              for (var item in snapshot.data!) {
                p = item;
              }
              final List<String> respuestas = p.posiblesRespuestas;
              final String respCorrecta = p.posiblesRespuestas[0];
              respuestas.shuffle();
            
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const _MyProgressBar(),
                  Text(
                    p.pregunta, // pregunta.....
                    style: const TextStyle(color: Colors.white, fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        //color: Colors.indigo[600],
                      ),
                      height: size.height * 0.30,
                      width: size.width * 0.80,
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                if (respuestas[index] ==
                                    respCorrecta) {
                                  print('resp correcta');
                                  //TODO Aqui va la insercion a la BD...
                                  partidaBloc.isTheCorrectAnswer();
                                }
                              },
                              child: Container(
                                margin: const EdgeInsets.all(10.0),
                                width: size.width * 0.70,
                                height: size.height * 0.05,
                                decoration: BoxDecoration(
                                    color: Colors.indigo[200],
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Text(
                                  respuestas[index],
                                  style: const TextStyle(
                                      fontSize: 15, color: AppThemes.blanco),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          })),
                  Flexible(
                      child: MyButtom(
                          textColor: Colors.white,
                          color: Colors.green,
                          text: 'Siguiente',
                          borderRadius: 10.0,
                          onClick: () {}))
                ],
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
      child: LinearProgressIndicator(
        value: 0.1,
        valueColor: const AlwaysStoppedAnimation<Color>(Colors.indigo),
        backgroundColor: Colors.indigo[200],
        minHeight: 20,
      ),
    );
  }
}
