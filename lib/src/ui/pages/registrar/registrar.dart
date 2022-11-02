
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazahua/src/dataBase/data_base.dart';
import 'package:mazahua/src/domain/blocs/blocs.dart';
import 'package:mazahua/src/ui/pages/pages.dart';

class Registrar extends StatefulWidget {
   
  const Registrar({Key? key}) : super(key: key);

  @override
  State<Registrar> createState() => _RegistrarState();
}

class _RegistrarState extends State<Registrar> {
  late RegistroBloc registerBloc;
  GlobalKey<FormState> registrarKey =  GlobalKey<FormState>();
  @override
  void initState() {
    registerBloc=BlocProvider.of<RegistroBloc>(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    final size =  MediaQuery.of(context).size;
    
    return  WillPopScope(
      onWillPop: ()async {
        return Future.value(true);
      },
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            width: size.width,
            height: size.height,
            decoration: _decoration(),
            child: Form(
              key: registrarKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.05),
                        child: IconButton(
                          onPressed: ()async => await MyAlerts.getOutAlert(context),
                          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppThemes.blanco,)
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top:size.height*0.05,),
                        child: const Text(
                          'Registrar',
                          style: TextStyle(
                            fontSize: 50,
                            color: AppThemes.morado,
                            fontWeight: FontWeight.bold 
                          ),
                        ),
                      ),
                      SizedBox(width: size.width *0.10,)
                      
                    ],
                  ),
                  SizedBox(height: size.height*0.20,),            
                  const MyTextFormField(labelText: 'Ingrese su nombre',isInputForPassword: false,inputBorderColor: AppThemes.morado,registro: true,),
                  SizedBox(height: size.height*0.05,),
                  const MyTextFormField(labelText: 'Ingrese su contraseña',isInputForPassword: true,inputBorderColor: AppThemes.morado, registro: true,),
                  const Expanded(child: Text('')),
                  Container(
                    margin: EdgeInsets.only(bottom:size.height*0.10),
                    child: MyButtom(
                      minWidth: 300,
                      height: 50,
                      textColor: AppThemes.blanco,
                      color: const Color.fromARGB(208, 86, 43, 91), 
                      text: 'Registrarme', 
                      borderRadius: 10.0, 
                      onClick: ()async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        if(registrarKey.currentState!.validate()){
                          final bool validateUser = await MazahuaDataBase.instance.validateUser(registerBloc.dataRegistro['nombre'], registerBloc.dataRegistro['password']);
                          if(validateUser){
                            // ya existe el usuario
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
                                  'Ese usuario ya esta registrado!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: AppThemes.blanco
                                  )
                                )
                              )
                            );
                          }
                          if(!validateUser){
                            final insertUser  = await MazahuaDataBase.instance.insertNewUser(
                              NewUser(
                                nombre:   registerBloc.dataRegistro['nombre'],
                                password: registerBloc.dataRegistro['password']
                              )
                            );
                            if(insertUser){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  dismissDirection: DismissDirection.up,
                                  duration: const Duration(seconds: 5),
                                  margin: const EdgeInsets.all(5.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)
                                  ),
                                  backgroundColor: const Color.fromARGB(219, 3, 157, 3),
                                  content: const Text(
                                    'Te has registrado correctamente',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: AppThemes.blanco
                                    )
                                  )
                                )
                              );
                              
                              Future.delayed(const Duration(seconds: 2)).then((_) =>  Navigator.of(context).pushNamed('home'));
                            }
                          }
                          //Navigator.pushNamed(context, 'repasoYevaluar');
                        }
                      }
                    ),
                  ),
                ]
              ),
            ),
          ),
        )
      ),
    );
  }
}

 BoxDecoration _decoration(){
    return const BoxDecoration(
          image: DecorationImage(
            filterQuality: FilterQuality.high,
            fit: BoxFit.cover,
            image: AssetImage('assets/backgrounds/register_background/fondo_de_registrar.jpg')
          ) 
        );
 }


 