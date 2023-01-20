
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'src/domain/blocs/blocs.dart';
import 'src/routes/routes.dart';


void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => RegistroBloc()),
      BlocProvider(create: (context) => LoginBloc()),
      BlocProvider(create: (context) => PartidaBloc()),
      BlocProvider(create: (context) => JuegoMatematicaBloc()),
    ], 
    child: const MyApp()
   )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.routes,
    );
  }
}




