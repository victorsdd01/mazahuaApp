

import 'package:mazahua/src/ui/pages/pages.dart';

class JuegoCienciasPage extends StatelessWidget {
  const JuegoCienciasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final User user =  ModalRoute.of(context)!.settings.arguments as User;
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppThemes.quizColor,
      ),
      body:  Container(
        decoration: const BoxDecoration(
          color: AppThemes.quizColor
        ),
        child: Column(
          children: [
            Stack(
              children: [
                const Positioned(
                  left: 30,
                  right: 30,
                  child: Text(
                    'Ponga las Partes correctas', 
                    style: TextStyle(
                      color: AppThemes.blanco, fontSize: 20
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30.0,),
                  child: Image.asset(
                    'assets/backgrounds/juego_ciencias/juego_ciencias.png',
                    fit: BoxFit.cover,
                    scale: 1,
                    height: size.height * 0.60,
                  ),
                )
              ],
            ),
            Expanded(
              child: Container(
                width: size.width,
                color: AppThemes.lightQuizColor,
                child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 10,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 2.0,
                    mainAxisSpacing: 2.0
                  ), 
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const  EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: AppThemes.quizColor,
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: const Text('name.mazahua', style: TextStyle(color: AppThemes.blanco),maxLines: 2, overflow: TextOverflow.ellipsis,)
                    );
                  }
                )
              ),
            )
          ],
        )
      ),
    );
  }
}