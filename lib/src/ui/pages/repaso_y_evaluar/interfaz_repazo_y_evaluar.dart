import 'package:mazahua/src/ui/pages/pages.dart';

class RepasoYevaluar extends StatelessWidget {
   
  const RepasoYevaluar({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final User user =  ModalRoute.of(context)!.settings.arguments as User;
    //print(' id: ${user.id}');
    //print(' nombre: ${user.nombre}');
    //print(' password: ${user.password}');
    return  WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 250,
          leading:  Padding(
            padding:  const EdgeInsets.only(left: 10.0,top: 20.0),
            child:  Text(user.nombre)
          ),
          automaticallyImplyLeading: false,
          actions: [
             IconButton(
              splashColor: AppThemes.transparente,
              icon: const Icon(Icons.exit_to_app), 
              onPressed: ()async{
                await MyAlerts.getOut(context);
              },             
            )
          ],
        ),
        body:Container(
          decoration:  const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/backgrounds/repaso_y_evaluar_background/repaso_y_evaluar.jpg')
            )
          ),
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MyButtom(
                  height: 50,
                  minWidth: 250,
                  textColor: AppThemes.blanco,
                  color: AppThemes.azul, 
                  text: 'Repaso', 
                  borderRadius: 10.0, 
                  onClick:()=> Navigator.pushNamed(context,'repaso')
                ),
                SizedBox(height: size.height*0.10,),
                MyButtom(
                  height: 50,
                  minWidth: 250,
                  textColor: AppThemes.blanco,
                  color: AppThemes.morado, 
                  text: 'Jugar', 
                  borderRadius: 10.0,
                  onClick:() => Navigator.of(context).pushNamed('jugar')
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}