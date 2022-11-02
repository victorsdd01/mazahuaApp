
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazahua/src/dataBase/data_base.dart';
import 'package:mazahua/src/domain/blocs/blocs.dart';
import 'package:mazahua/src/ui/pages/pages.dart';

class LoginPage extends StatefulWidget {
   
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  late LoginBloc loginBloc;
  @override
  void initState() {
    loginBloc = BlocProvider.of<LoginBloc>(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Stack(
            children:[
              Container(
                width: size.width,
                height: size.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/backgrounds/login_background/fondo_inicio_sesion.jpg')
                  )
                ),
                child: Column(
                  children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(top:size.height*0.05),
                          child: const Text(
                            'Iniciar Sesion',
                            style: TextStyle(
                              fontSize: 50,
                              color: AppThemes.azul,
                              fontWeight: FontWeight.bold 
                            ),
                          ),
                      ),
                      Image.asset('assets/icons/iniciar_sesion.png',height: size.height*0.30,),
                      Expanded(
                          child: Form(
                            key:loginKey,
                            child: Column(
                              children:[
                                const MyTextFormField(labelText: 'Ingrese su nombre',isInputForPassword: false, inputBorderColor: AppThemes.azul, login: true,),
                                SizedBox(height: size.height*0.05,),
                                const MyTextFormField(labelText: 'Ingrese su contraseña',isInputForPassword: true,inputBorderColor: AppThemes.azul,login: true,),
                                const Expanded(child: Text('')),
                                Container(
                                  margin: EdgeInsets.only(bottom:size.height*0.10),
                                  child: MyButtom(
                                    minWidth: 300,
                                    height: 50,
                                    textColor: AppThemes.blanco,
                                    color: AppThemes.azul, 
                                    text: 'Iniciar sesion', 
                                    borderRadius: 10.0, 
                                    onClick: ()async {
                                      if(loginKey.currentState!.validate()){
                                        // ignore: todo
                                        //TODO: Aqui validamos al usuario de la base de datos...
                                        final bool result = await MazahuaDataBase.instance.validateUser(loginBloc.loginData['nombre'], loginBloc.loginData['password']);
                                        if(!result){
                                          ScaffoldMessenger.of(context).showSnackBar(
                                             SnackBar(
                                              behavior: SnackBarBehavior.floating,
                                              dismissDirection: DismissDirection.up,
                                              duration: const Duration(seconds: 5),
                                              margin: const EdgeInsets.all(5.0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10.0)
                                              ),
                                              backgroundColor: AppThemes.rojo,
                                              content: const Text(
                                                'Usuario o contraseña incorrectos!',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                  color: AppThemes.blanco
                                                )
                                              )
                                            )
                                          );
                                        }
                                        if(result){
                                          final User userInfo = await MazahuaDataBase.instance.getUserInfo(loginBloc.loginData['nombre']);
                                          Navigator.pushNamed(context, 'repasoYevaluar', arguments: userInfo);
                                        }
                                      }
                                    }
                                  ),
                                )
                              ],
                            )
                          ),
                        ),
                  ],
                ),
              ),
              Positioned(
                top: size.height * 0.05,
                child: IconButton(
                  onPressed: () async {
                    await MyAlerts.getOutAlert(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppThemes.blanco,)
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
