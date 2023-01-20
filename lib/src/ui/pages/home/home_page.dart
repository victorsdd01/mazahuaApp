import 'dart:io' show Platform;
import 'package:mazahua/src/dataBase/data_base.dart';
import 'package:mazahua/src/ui/pages/pages.dart';


class HomePage extends StatelessWidget {
   
  const HomePage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    
    MazahuaDataBase.instance.dataBase;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: _decoration(),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //verticalDirection: VerticalDirection.down,
            children: <Widget>[
               Padding(
                padding:  EdgeInsets.only(top:size.height*0.05),
                child:  const Text('App Mazahua', 
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.italic
                  ),
                 ),
              ),
              Image.asset(
                'assets/icons/mazahua.png',
                height: size.height*0.60,
              ),
              Expanded(
                child: Column(
                  children:<Widget>[
                    MyButtom(text: 'Registrar',textColor: Colors.white,minWidth: 200, color: Colors.amber,borderRadius : 12.0, onClick:()=> onRegistrar(context),),
                    MyButtom(text: 'Entrar'   ,textColor: Colors.white,minWidth: 200, color: Colors.green,borderRadius : 12.0, onClick:()=> onEntrar(context),),
                    MyButtom(text: 'Salir'    ,textColor: Colors.white,minWidth: 200, color: Colors.pink, borderRadius : 12.0,onClick :()=> onSalir(context),),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void onRegistrar(BuildContext context) => Navigator.of(context).pushNamed('registrar');

void onEntrar(BuildContext context) => Navigator.of(context).pushNamed('login');

 Future<void> onSalir(BuildContext context) async {
  final  currentPlatform =  Platform.operatingSystem.toUpperCase();
  switch (currentPlatform) {
    case 'ANDROID':
      await MyAlerts.exitApp(context);
      break;
    case 'IOS':
      await MyAlerts.exitIOSApp(context,currentPlatform);
      break;
    default:
  }
}


BoxDecoration  _decoration(){
  const List<Color> colors = [
    Color(0xff00f7fe),
    Color(0xff32a8ff)
  ];
  return const BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin : Alignment.bottomLeft,
            end   : Alignment.centerRight 
          ),
        );
}