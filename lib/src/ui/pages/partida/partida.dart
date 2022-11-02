
import 'package:mazahua/src/dataBase/data_base.dart';
import 'package:mazahua/src/ui/pages/pages.dart';

class PartidaPage extends StatelessWidget {
   
  const PartidaPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final Niveles nivel = ModalRoute.of(context)!.settings.arguments as Niveles;
    final size = MediaQuery.of(context).size;
    return  Scaffold(
      backgroundColor: Colors.indigo[300],
      appBar: AppBar(
        title: Text(nivel.nombreNivel),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Preguntas>>(
        future: MazahuaDataBase.instance.getPreguntas(),
        builder: (BuildContext context, AsyncSnapshot<List<Preguntas>> snapshot){
          if(snapshot.hasData){
            late Preguntas p;
            for (var item in snapshot.data!) {
              p = item;
              print('${p.posiblesRespuestas[1]}');
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const _MyProgressBar(),
                const Text('Pregunta', style: TextStyle(color: Colors.white, fontSize: 30),),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.indigo[600],
                  ),
                  height: size.height * 0.30,
                  width: size.width *0.80,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      final Preguntas opciones = snapshot.data![1];
                      print("-----> opciones: ${opciones.posiblesRespuestas}");
                      return GestureDetector(
                      onTap: ()=>print('clicked:$index'),
                      child: Container(
                        margin: const EdgeInsets.all(10.0),
                        width: size.width *0.70,
                        height: size.height *0.05,
                        decoration: BoxDecoration(
                          color: Colors.indigo[200],
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: Text('data'),
                      ),
                    );
                    }
                  )
                ),
                Flexible(
                  child: MyButtom(
                    textColor: Colors.white,
                    color: Colors.green, 
                    text: 'Siguiente', 
                    borderRadius: 10.0, 
                    onClick: (){
                      
                    }
                  )
                )
              ],
            );
          }else{
            return const Center(child: CircularProgressIndicator.adaptive(),);
          }
        },
      )
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
      margin: const EdgeInsets.only(left: 10.0,right: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0)
      ),
      child:  LinearProgressIndicator(
        value: 0.1,
        valueColor: const AlwaysStoppedAnimation<Color>(Colors.indigo),
        backgroundColor: Colors.indigo[200],
        minHeight: 20,
      ),
    );
  }
}