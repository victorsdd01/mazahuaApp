
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:mazahua/src/data/models/models.dart';
import 'package:mazahua/src/ui/pages/pages.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MazahuaDataBase{

  static final MazahuaDataBase instance =  MazahuaDataBase._init();
  static Database? _database;

  //Tables
  final String tablaUsaurios        = "USUARIOS";
  final String tablaCategoria       = "CATEGORIA";
  final String tablaNumeros         = "NUMEROS";
  final String tablaAnimales        = "ANIMALES";
  final String tablaFrutasYverduras = "FRUTAS_Y_VERDURAS";
  final String tablaColores         = "COLORES";
  final String tablaPartesDelCuerpo = "PARTES_DEL_CUERPO";
  final String tablaNiveles         = "NIVELES"; 
  final String tablaVocabulario     = "VOCABULARIO";
  final String tablaPreguntas       = "PREGUNTAS";
  final String tablaTipoJuego       = "TIPO_DE_JUEGO";
  final String tablaJuegoMatematica = "JUEGO_MATEMATICAS";

  MazahuaDataBase._init();

    Future<Database> get dataBase async {
      if(_database != null ){
        if (kDebugMode) {
          print('ya existe la bd');
        }
        return _database!;
      }

        _database =  await _initDB('MazahuaApp.db');
        if (kDebugMode) {
          print(" no existe la bd , se va a crear");
        }
        return _database!;
      
    }
    
     Future<Database> _initDB(String filePath) async {
      try {  
        final dbPath = await getDatabasesPath();
        final path =  join(dbPath,filePath);
        print(path);
        return openDatabase(path,onCreate: _onCreateDB,version: 1);
      } on DatabaseException{
        if (kDebugMode) {
          print('❌Ocurrio un error con la base de datos.... _initDB');
        }
        return dataBase;
      }
     }
 
  FutureOr<void> _onCreateDB(Database db, int version) async {
    if (kDebugMode) {
      print("creando...");
    }
    await db.execute(
      '''
         CREATE TABLE $tablaUsaurios (
	         "id_usuario"	INTEGER NOT NULL,
	         "nombre_usuario"	TEXT NOT NULL,
	         "password_usuario"	TEXT NOT NULL,
	         PRIMARY KEY("id_usuario" AUTOINCREMENT)
         );
      '''
    );

    await db.execute(
      '''
        CREATE TABLE $tablaNiveles (
          "id_nivel"  INTEGER NOT NULL,
          "nombre_nivel" VARCHAR(50) NOT NULL,
          PRIMARY KEY("id_nivel" AUTOINCREMENT)
        );
      '''
    );
    await db.execute(
      '''
        CREATE TABLE $tablaCategoria (
          "id_categoria" INTEGER NOT NULL ,
          "nombre_categoria" VARCHAR (100) NOT NULL,
          "url_image_categoria" VARCHAR(800),
          PRIMARY KEY("id_categoria" AUTOINCREMENT)
        );
      '''
    );

    await db.execute(
      '''
        CREATE TABLE $tablaNumeros (
          "id_numero" INTEGER NOT NULL,
          "url_image_numero" VARCHAR(800)  NOT NULL,
          "url_sound_numero" VARCHAR(800)  NOT NULL,
          "nombre_num_esp"   VARCHAR(100)  NOT NULL,
          "nombre_num_mazahua" VARCHAR(100) NOT NULL,
          PRIMARY KEY("id_numero" AUTOINCREMENT)
        );
      '''
    );
    await db.execute(
      '''
        CREATE TABLE $tablaAnimales (
          "id_animal" INTEGER NOT NULL,
          "url_image_animal" VARCHAR(800)  NOT NULL,
          "url_sound_animal" VARCHAR(800)  NOT NULL,
          "nombre_an_esp"   VARCHAR(100)   NOT NULL,
          "nombre_an_mazahua" VARCHAR(100) NOT NULL,
          PRIMARY KEY("id_animal" AUTOINCREMENT)
        );
      '''
    );
    await db.execute(
      '''
        CREATE TABLE $tablaFrutasYverduras (
          "id_fv" INTEGER NOT NULL,
          "url_image_fv" VARCHAR(800)      NOT NULL,
          "url_sound_fv" VARCHAR(800)      NOT NULL,
          "nombre_fv_esp"   VARCHAR(100)   NOT NULL,
          "nombre_fv_mazahua" VARCHAR(100) NOT NULL,
          PRIMARY KEY("id_fv" AUTOINCREMENT)
        );
      '''
    );

    await db.execute(
      '''
        CREATE TABLE $tablaColores (
          "id_color" INTEGER NOT NULL,
          "url_image_color" VARCHAR(800)      NOT NULL,
          "url_sound_color" VARCHAR(800)      NOT NULL,
          "nombre_fv_esp"   VARCHAR(100)   NOT NULL,
          "nombre_fv_mazahua" VARCHAR(100) NOT NULL,
          PRIMARY KEY("id_color" AUTOINCREMENT)
        );
      '''
    );

    await db.execute(
      '''
        CREATE TABLE $tablaPartesDelCuerpo (
          "id_pdc" INTEGER NOT NULL,
          "url_image_pdc" VARCHAR(800)      NOT NULL,
          "url_sound_pdc" VARCHAR(800)      NOT NULL,
          "nombre_fv_esp"   VARCHAR(100)   NOT NULL,
          "nombre_fv_mazahua" VARCHAR(100) NOT NULL,
          PRIMARY KEY("id_pdc" AUTOINCREMENT)
        );
      '''
    );

    await db.execute(
    '''
    CREATE TABLE $tablaVocabulario (
          "id_vocabulario" INTEGER NOT NULL,
          "url_image_voc" VARCHAR(800)     NOT NULL,
          "url_sound_voc" VARCHAR(800)     NOT NULL,
          "nombre_fv_mazahua" VARCHAR(100) NOT NULL,
          PRIMARY KEY("id_vocabulario" AUTOINCREMENT)
        );
    '''
    );

    await db.execute(
      '''
        CREATE TABLE $tablaPreguntas(
          id_pregunta INTEGER  NOT NULL,
          pregunta VARCHAR(1500) NOT NULL,
          respuesta_correcta VARCHAR(500)    NOT NULL,
          respuesta_incorrecta1 VARCHAR(500) NOT NULL,
          respuesta_incorrecta2 VARCHAR(500) NOT NULL,
          respuesta_incorrecta3 VARCHAR(500) NOT NULL,
          img_pregunta VARCHAR(500)   NOT NULL,
          audio_pregunta VARCHAR(200) NOT NULL,
          tipo_pregunta VARCHAR(150)  NOT NULL,
          categoria_pregunta VARCHAR(300) NOT NULL,
          PRIMARY KEY("id_pregunta" AUTOINCREMENT)
        );
      '''
    );

    await db.execute(
      ''' 
          CREATE TABLE $tablaTipoJuego (
            id_tipo_juego INTEGER NOT NULL,
            nombre_juego VARCHAR (500) NOT NULL,
            tipo_juego VARCHAR(100) NOT NULL,
            imagen_juego VARCHAR(1500) NOT NULL,
            materia_juego  VARCHAR(500) NOT NULL,
            PRIMARY KEY("id_tipo_juego" AUTOINCREMENT)
          );
      '''
    );


    await db.execute(
      '''
        CREATE TABLE $tablaJuegoMatematica (
          id_juegoMat INTEGER NOT NULL,
          tipo_juego VARCHAR(200) NOT NULL,
          tipo_de_operacion VARCHAR(150) NOT NULL,
          valor_1 VARCHAR(50) NOT NULL,
          valor_2 VARCHAR(50) NOT NULL, 
          resp_correcta VARCHAR(500) NOT NULL,
          resp_incorrecta VARCHAR(500) NOT NULL,
          PRIMARY KEY("id_juegoMat" AUTOINCREMENT)
        );
      '''
    );



    // INSERTS

    //JUEGO DE MATEMATICAS

    await db.execute("INSERT INTO $tablaJuegoMatematica VALUES(NULL,'seleccionar','suma','5','5','diez','dos');");
    await db.execute("INSERT INTO $tablaJuegoMatematica VALUES(NULL,'seleccionar','resta','5','4','uno','nueve');");
    await db.execute("INSERT INTO $tablaJuegoMatematica VALUES(NULL,'seleccionar','multiplicacion','2','3','seis','uno');");
    await db.execute("INSERT INTO $tablaJuegoMatematica VALUES(NULL,'seleccionar','division','10','2','cinco','uno');");



    // PREGUNTAS
     await db.execute("INSERT INTO $tablaPreguntas VALUES (NULL,'¿Cual es el significado de YEJE?','Dos','Tres','Ocho','Diez','numeros/dos.png','dos.m4a','normal','numeros');");
     await db.execute("INSERT INTO $tablaPreguntas VALUES (NULL,'Selecciona la respuesta correcta de acuerdo a la imagen','Zapote','Melon','Pera','Manzana','fv/zapote.png','zapote.m4a','imagen-normal','fv');");
     await db.execute("INSERT INTO $tablaPreguntas VALUES (NULL,'Selecciona la respuesta correcta de acuerdo al sonido','Aguacate','Papa','Zarzamora','Tuna','fv/aguacate.png','aguacate.m4a','audio','fv');");
     await db.execute("INSERT INTO $tablaPreguntas VALUES (NULL,'¿Cual de estas es MBAJA','Rojo','Negro','Azul','Rosa','colores/rojo.png','rojo.m4a','normal-imagen','colores');");
     await db.execute("INSERT INTO $tablaPreguntas VALUES (NULL,'Seleccione la respuesta correcta','Dedo de mano','Cerebro','Espalda','Cara','pdc/dedo de mano.png','dedo de mano.m4a','normal-audio','pdc');");
     await db.execute("INSERT INTO $tablaPreguntas VALUES (NULL,'¿Cual es el significado de Gris?','Gris','Morado','Negro','Cafe','colores/gris.png','gris.m4a','normal-audio','colores');");
    //  await db.execute("INSERT INTO $tablaPreguntas VALUES (NULL,'¿Cual es el significado de MADYE?','Brazo','Blanco','Mano','Azul','brazo.png','brazo.m4a');");
    //  await db.execute("INSERT INTO $tablaPreguntas VALUES (NULL,'¿Cual es el significado de MEXA?','Mesa','Madera','Libro','Morado','mesa.png','mesa.m4a');");

    //NIVELES

    await db.execute("INSERT INTO $tablaNiveles VALUES(NULL,'FACIL');");
    await db.execute("INSERT INTO $tablaNiveles VALUES(NULL,'MEDIO');");
    await db.execute("INSERT INTO $tablaNiveles VALUES(NULL,'DIFICIL');");

    //------------CATEGORIAS-------
    await db.execute("INSERT INTO $tablaCategoria VALUES (NULL,'Numeros','numeros.png');");
    await db.execute("INSERT INTO $tablaCategoria VALUES (NULL,'Animales','animales.png');");
    await db.execute("INSERT INTO $tablaCategoria VALUES (NULL,'Colores','colores.png');");
    await db.execute("INSERT INTO $tablaCategoria VALUES (NULL,'Frutas y verduras','fyv.png');");
    await db.execute("INSERT INTO $tablaCategoria VALUES (NULL,'Partes del cuerpo','pdc.png');");
    await db.execute("INSERT INTO $tablaCategoria VALUES (NULL,'Vocabulario general','vocabulario.png');");
    // -----------NUMEROS ------------
    await db.execute("INSERT INTO $tablaNumeros VALUES(NULL,'uno.png','uno.m4a','uno','d´aja');");
    await db.execute("INSERT INTO $tablaNumeros VALUES(NULL,'dos.png','dos.m4a','dos','yeje');");
    await db.execute("INSERT INTO $tablaNumeros VALUES(NULL,'tres.png','tres.m4a','tres','jñi´i');");
    await db.execute("INSERT INTO $tablaNumeros VALUES(NULL,'cuatro.png','cuatro.m4a','cuatro','nzijo');");
    await db.execute("INSERT INTO $tablaNumeros VALUES(NULL,'cinco.png','cinco.m4a','cinco','ts´ich´a');");
    await db.execute("INSERT INTO $tablaNumeros VALUES(NULL,'seis.png','seis.m4a','seis','ñanrro');");
    await db.execute("INSERT INTO $tablaNumeros VALUES(NULL,'siete.png','siete.m4a','siete','yencho');");
    await db.execute("INSERT INTO $tablaNumeros VALUES(NULL,'ocho.png','ocho.m4a','ocho','jñincho');");
    await db.execute("INSERT INTO $tablaNumeros VALUES(NULL,'nueve.png','nueve.m4a','nueve','nzincho');");
    await db.execute("INSERT INTO $tablaNumeros VALUES(NULL,'diez.png','diez.m4a','diez','dyech´a');");
    //------------ ANIMALES----
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'abeja.png','abeja.m4a','abeja','ngunu');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'aguila.png','aguila.m4a','aguila','satajma');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'ajolote.png','ajolote.m4a','ajolote','zukjob u');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'araña.png','araña.m4a','araña','mexe');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'ardilla.png','ardilla.m4a','ardilla','miñi');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'armadillo.png','armadillo.m4a','armadillo','ndozo');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'borrego.png','borrego.m4a','borrego','nrrenchjuru');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'burro.png','burro.m4a','burro','burru');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'caballo.png','caballo.m4a','caballo','pjad u');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'cabra.png','cabra.m4a','cabra','chiba');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'cerdo.png','cerdo.m4a','cerdo','kuchi');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'colibri.png','colibri.m4a','colibri','ts ik utr u');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'conejo.png','conejo.m4a','conejo','kjua a');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'coyote.png','coyote.m4a','coyote','mindyo');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'cuervo.png','cuervo.m4a','cuervo','k aa');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'escorpion.png','escorpion.m4a','escorpion','dyeza');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'gallo.png','gallo.m4a','gallo','cha´a');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'gato.png','gato.m4a','gato','misi');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'gavilan.png','gavilan.m4a','gavilan','pensu');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'grillo.png','grillo.m4a','grillo','tr unxu');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'guajolota.png','guajolota.m4a','guajolota','suajna');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'guajolote.png','guajolote.m4a','guajolote','maxa');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'gusano.png','gusano.m4a','gusano','dyoxu');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'hormiga.png','hormiga.m4a','hormiga','xakju');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'lagartija.png','lagartija.m4a','lagartija','yurga');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'lechuza.png','lechuza.m4a','lechuza','tuxculu');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'leon.png','leon.m4a','leon','miji');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'lombriz.png','lombriz.m4a','lombriz','m asa');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'mapache.png','mapache.m4a','mapache','nzikue');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'mariposa.png','mariposa.m4a','mariposa','tixjmo');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'mosca.png','mosca.m4a','mosca','moro');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'murcielago.png','murcielago.m4a','murcielago','ngonza');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'pajaro.png','pajaro.m4a','pajaro','s uu');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'paloma.png','paloma.m4a','paloma','bilo');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'pato.png','pato.m4a','pato','mbaro');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'perro.png','perro.m4a','perro','dyø´ø');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'pescado.png','pescado.m4a','pescado','jmo_´o_');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'piojo.png','piojo.m4a','piojo','t´øø');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'pollo.png','pollo.m4a','pollo','ngoñi');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'pulga.png','pulga.m4a','pulga','øø');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'raton.png','raton.m4a','raton','ngo_´o_');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'rana.png','rana.m4a','rana','we e');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'renacuajo.png','renacuajo.m4a','renacuajo','zambo');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'sanguijuela.png','sanguijuela.m4a','sanguijuela','guiseeme');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'tigre.png','tigre.m4a','tigre','masna');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'toro.png','toro.m4a','toro','nzhunu');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'vaca.png','vaca.m4a','vaca','b aga');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'venado.png','venado.m4a','venado','pjantrjeje');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'vivora.png','vivora.m4a','vivora','k´ijmi');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'yegua.png','yegua.m4a','yegua','supjad u');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'zopilote.png','zopilote.m4a','zopilote','nroparu');");
    await db.execute("INSERT INTO $tablaAnimales VALUES(NULL,'zorrillo.png','zorrillo.m4a','zorrillo','u´jmu´');");
    // FRUTAS Y VERDURAS
    await db.execute("INSERT INTO $tablaFrutasYverduras VALUES(NULL,'aguacate.png','aguacate.m4a','aguacate','sonnaa');");
    await db.execute("INSERT INTO $tablaFrutasYverduras VALUES(NULL,'durazno.png','durazno.m4a','durazno','nrrora');");
    await db.execute("INSERT INTO $tablaFrutasYverduras VALUES(NULL,'guayaba.png','guayaba.m4a','guayaba','xapedyi');");
    await db.execute("INSERT INTO $tablaFrutasYverduras VALUES(NULL,'manzana.png','manzana.m4a','manzana','ixi');");
    await db.execute("INSERT INTO $tablaFrutasYverduras VALUES(NULL,'pera.png','pera.m4a','pera','peraxu');");
    await db.execute("INSERT INTO $tablaFrutasYverduras VALUES(NULL,'platano.png','platano.m4a','platano','nrranxa');");
    await db.execute("INSERT INTO $tablaFrutasYverduras VALUES(NULL,'tejocote.png','tejocote.m4a','tejocote','p´edyi');");
    await db.execute("INSERT INTO $tablaFrutasYverduras VALUES(NULL,'tuna.png','tuna.m4a','tuna','nukijñi');");
    await db.execute("INSERT INTO $tablaFrutasYverduras VALUES(NULL,'zapote.png','zapote.m4a','zapote','muza');");
    await db.execute("INSERT INTO $tablaFrutasYverduras VALUES(NULL,'zarzamora.png','zarzamora.m4a','zarzamora','xaxatr´u');");
    await db.execute("INSERT INTO $tablaFrutasYverduras VALUES(NULL,'caña.png','caña.m4a','caña','dyë´ë');");
    await db.execute("INSERT INTO $tablaFrutasYverduras VALUES(NULL,'capulin.png','capulin.m4a','capulin','nrrensje');");
    await db.execute("INSERT INTO $tablaFrutasYverduras VALUES(NULL,'jitomate.png','jitomate.m4a','jitomate','mbanrremoxu');");
    await db.execute("INSERT INTO $tablaFrutasYverduras VALUES(NULL,'tomate.png','tomate.m4a','tomate','tr´oxtr´emoxu');");
    await db.execute("INSERT INTO $tablaFrutasYverduras VALUES(NULL,'papa.png','papa.m4a','papa','d´ok´a');");
    await db.execute("INSERT INTO $tablaFrutasYverduras VALUES(NULL,'quintonil.png','quintonil.m4a','quintonil','xitsjo');");
    await db.execute("INSERT INTO $tablaFrutasYverduras VALUES(NULL,'cebolla.png','cebolla.m4a','cebolla','nrrenxu');");
    await db.execute("INSERT INTO $tablaFrutasYverduras VALUES(NULL,'chile verde.png','chile verde.m4a','chile verde','k´angi');");
    await db.execute("INSERT INTO $tablaFrutasYverduras VALUES(NULL,'haba.png','haba.m4a','haba','nrakju');");
    await db.execute("INSERT INTO $tablaFrutasYverduras VALUES(NULL,'ajo.png','ajo.m4a','ajo','axuxi');");
    await db.execute("INSERT INTO $tablaFrutasYverduras VALUES(NULL,'chile rojo.png','chile rojo.m4a','chile rojo','mbai');");
    await db.execute("INSERT INTO $tablaFrutasYverduras VALUES(NULL,'calabaza.png','calabaza.m4a','calabaza','mu_´u_');");
    await db.execute("INSERT INTO $tablaFrutasYverduras VALUES(NULL,'chile.png','chile.m4a','chile','i´i');");
    await db.execute("INSERT INTO $tablaFrutasYverduras VALUES(NULL,'ejote.png','ejote.m4a','ejote','makju');");
    await db.execute("INSERT INTO $tablaFrutasYverduras VALUES(NULL,'navo.png','navo.m4a','navo','nauxi');");
    await db.execute("INSERT INTO $tablaFrutasYverduras VALUES(NULL,'elote.png','elote.m4a','elote','muxa');");
    await db.execute("INSERT INTO $tablaFrutasYverduras VALUES(NULL,'nopal.png','nopal.m4a','nopal','kijñi');");
    await db.execute("INSERT INTO $tablaFrutasYverduras VALUES(NULL,'chicharo.png','chicharo.m4a','chicharo','t´oxkju');");
    await db.execute("INSERT INTO $tablaFrutasYverduras VALUES(NULL,'hongo.png','hongo.m4a','hongo','kjo´o');");
    await db.execute("INSERT INTO $tablaFrutasYverduras VALUES(NULL,'quelite.png','quelite.m4a','quelite','kajna');");
    await db.execute("INSERT INTO $tablaFrutasYverduras VALUES(NULL,'limon.png','limon.m4a','limon','limu');");
    await db.execute("INSERT INTO $tablaFrutasYverduras VALUES(NULL,'chivitos.png','chivitos.m4a','chivitos','m´uru');");
    await db.execute("INSERT INTO $tablaFrutasYverduras VALUES(NULL,'camote.png','camote.m4a','camote','nbengoma');");
    await db.execute("INSERT INTO $tablaFrutasYverduras VALUES(NULL,'malva.png','malva.m4a','malva','nrra´ojna');");
    await db.execute("INSERT INTO $tablaFrutasYverduras VALUES(NULL,'chayote.png','chayote.m4a','chayote','xamu');");
    await db.execute("INSERT INTO $tablaFrutasYverduras VALUES(NULL,'jaltomate.png','jaltomate.m4a','jaltomate','ndempe');");
    // ------- COLORES
    await db.execute("INSERT INTO $tablaColores VALUES(NULL,'amarillo.png','amarillo.m4a','amarillo','k axtr u');");
    await db.execute("INSERT INTO $tablaColores VALUES(NULL,'rosa.png','rosa.m4a','rosa','ixki');");
    await db.execute("INSERT INTO $tablaColores VALUES(NULL,'arananjado.png','arananjado.m4a','arananjado','kjei');");
    await db.execute("INSERT INTO $tablaColores VALUES(NULL,'azul.png','azul.m4a','azul','kanga');");
    await db.execute("INSERT INTO $tablaColores VALUES(NULL,'blanco.png','blanco.m4a','blanco','tr oxu');");
    await db.execute("INSERT INTO $tablaColores VALUES(NULL,'cafe.png','cafe.m4a','cafe','kjoxu');");
    await db.execute("INSERT INTO $tablaColores VALUES(NULL,'negro.png','negro.m4a','negro','potrja');");
    await db.execute("INSERT INTO $tablaColores VALUES(NULL,'rojo.png','rojo.m4a','rojo','mbaja');");
    await db.execute("INSERT INTO $tablaColores VALUES(NULL,'verde.png','verde.m4a','verde','mbezhe');");
    await db.execute("INSERT INTO $tablaColores VALUES(NULL,'morado.png','morado.m4a','morado','kangu');");
    await db.execute("INSERT INTO $tablaColores VALUES(NULL,'gris.png','gris.m4a','gris','poxu');");
    // ------- PARTES DEL CUERPO ----
    await db.execute("INSERT INTO $tablaPartesDelCuerpo VALUES(NULL,'boca.png','boca.m4a','boca','ne e');");
    await db.execute("INSERT INTO $tablaPartesDelCuerpo VALUES(NULL,'brazo.png','brazo.m4a','brazo','madye');");
    await db.execute("INSERT INTO $tablaPartesDelCuerpo VALUES(NULL,'cabello.png','cabello.m4a','cabello','nixtrjiji');");
    await db.execute("INSERT INTO $tablaPartesDelCuerpo VALUES(NULL,'cabeza.png','cabeza.m4a','cabeza','nroñi');");
    await db.execute("INSERT INTO $tablaPartesDelCuerpo VALUES(NULL,'cara.png','cara.m4a','cara','jmi i');");
    await db.execute("INSERT INTO $tablaPartesDelCuerpo VALUES(NULL,'ceja.png','ceja.m4a','ceja','xizho');");
    await db.execute("INSERT INTO $tablaPartesDelCuerpo VALUES(NULL,'cerebro.png','cerebro.m4a','cerebro','mbeñakju');");
    await db.execute("INSERT INTO $tablaPartesDelCuerpo VALUES(NULL,'cintura.png','cintura.m4a','cintura','ximatrja');");
    await db.execute("INSERT INTO $tablaPartesDelCuerpo VALUES(NULL,'codo.png','codo.m4a','codo','yud u');");
    await db.execute("INSERT INTO $tablaPartesDelCuerpo VALUES(NULL,'corazon.png','corazon.m4a','corazon','mub u');");
    await db.execute("INSERT INTO $tablaPartesDelCuerpo VALUES(NULL,'cuello.png','cuello.m4a','cuello','dyizi');");
    await db.execute("INSERT INTO $tablaPartesDelCuerpo VALUES(NULL,'dedo de mano.png','dedo de mano.m4a','dedo de mano','nidye');");
    await db.execute("INSERT INTO $tablaPartesDelCuerpo VALUES(NULL,'dedo de pie.png','dedo de pie.m4a','dedo de pie','ñimo');");
    await db.execute("INSERT INTO $tablaPartesDelCuerpo VALUES(NULL,'diente.png','diente.m4a','diente','s ib i');");
    await db.execute("INSERT INTO $tablaPartesDelCuerpo VALUES(NULL,'espalda.png','espalda.m4a','espalda','xutrju');");
    await db.execute("INSERT INTO $tablaPartesDelCuerpo VALUES(NULL,'espinilla.png','espinilla.m4a','espinilla','xijmi');");
    await db.execute("INSERT INTO $tablaPartesDelCuerpo VALUES(NULL,'estomago.png','estomago.m4a','estomago','ñimb u');");
    await db.execute("INSERT INTO $tablaPartesDelCuerpo VALUES(NULL,'garganta.png','garganta.m4a','garganta','trjuxu');");
    await db.execute("INSERT INTO $tablaPartesDelCuerpo VALUES(NULL,'hombro.png','hombro.m4a','hombro','jyo');");
    await db.execute("INSERT INTO $tablaPartesDelCuerpo VALUES(NULL,'hueso.png','hueso.m4a','hueso','nrodye');");
    await db.execute("INSERT INTO $tablaPartesDelCuerpo VALUES(NULL,'intestino.png','intestino.m4a','intestino','xempjojo');");
    await db.execute("INSERT INTO $tablaPartesDelCuerpo VALUES(NULL,'lengua.png','lengua.m4a','lengua','k ijñi');");
    await db.execute("INSERT INTO $tablaPartesDelCuerpo VALUES(NULL,'mano.png','mano.m4a','mano','dye e');");
    await db.execute("INSERT INTO $tablaPartesDelCuerpo VALUES(NULL,'nariz.png','nariz.m4a','nariz','b oxu');");
    await db.execute("INSERT INTO $tablaPartesDelCuerpo VALUES(NULL,'ojo.png','ojo.m4a','ojo','nro o');");
    await db.execute("INSERT INTO $tablaPartesDelCuerpo VALUES(NULL,'ombligo.png','ombligo.m4a','ombligo','s ona');");
    await db.execute("INSERT INTO $tablaPartesDelCuerpo VALUES(NULL,'oreja.png','oreja.m4a','oreja','ngo o');");
    await db.execute("INSERT INTO $tablaPartesDelCuerpo VALUES(NULL,'palma de mano.png','palma de mano.m4a','palma de mano','mbadye');");
    await db.execute("INSERT INTO $tablaPartesDelCuerpo VALUES(NULL,'pecho.png','pecho.m4a','pecho','tr ijmi');");
    await db.execute("INSERT INTO $tablaPartesDelCuerpo VALUES(NULL,'pestaña.png','pestaña.m4a','pestaña','xizho');");
    await db.execute("INSERT INTO $tablaPartesDelCuerpo VALUES(NULL,'pie.png','pie.m4a','pie','ngwa');");
    await db.execute("INSERT INTO $tablaPartesDelCuerpo VALUES(NULL,'piel.png','piel.m4a','piel','xipjad u');");
    await db.execute("INSERT INTO $tablaPartesDelCuerpo VALUES(NULL,'pierna.png','pierna.m4a','pierna','nzo o');");
    await db.execute("INSERT INTO $tablaPartesDelCuerpo VALUES(NULL,'riñon.png','riñon.m4a','riñon','riñu');");
    await db.execute("INSERT INTO $tablaPartesDelCuerpo VALUES(NULL,'rodilla.png','rodilla.m4a','rodilla','ch ijmi');");
    await db.execute("INSERT INTO $tablaPartesDelCuerpo VALUES(NULL,'sangre.png','sangre.m4a','sangre','kji i');");
    await db.execute("INSERT INTO $tablaPartesDelCuerpo VALUES(NULL,'talon.png','talon.m4a','talon','nrungwa');");
    await db.execute("INSERT INTO $tablaPartesDelCuerpo VALUES(NULL,'tobillo.png','tobillo.m4a','tobillo','ongwa');");
    await db.execute("INSERT INTO $tablaPartesDelCuerpo VALUES(NULL,'vello.png','vello.m4a','vello','xi i');");
    await db.execute("INSERT INTO $tablaPartesDelCuerpo VALUES(NULL,'vena.png','vena.m4a','vena','ñitsji');");
    await db.execute("INSERT INTO $tablaPartesDelCuerpo VALUES(NULL,'uña.png','uña.m4a','uña','xo o');");
    await db.execute("INSERT INTO $tablaPartesDelCuerpo VALUES(NULL,'higado.png','higado.m4a','higado','kjurga');");
    // VOCABULARIO

    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'casa.png','casa.m4a','ngumu');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'puerta.png','puerta.m4a','ngoxti');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'plato.png','plato.m4a','mojmu');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'comedor.png','comedor.m4a','Jango ñonúji');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'cuchillo.png','cuchillo.m4a',' tjedyi');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'fogon.png','fogon.m4a','ngosibi');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'molcajete.png','molcajete.m4a','manza');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'metate.png','metate.m4a','kjujnu');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'olla.png','olla.m4a','sa ba');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'cal.png','cal.m4a','ñonu');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'silla.png','silla.m4a','tjujnu');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'mesa.png','mesa.m4a','mexa');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'estufa.png','estufa.m4a','si bi');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'cazuela.png','cazuela.m4a','nrajmu');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'cuchara.png','cuchara.m4a','juañi');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'cantaro.png','cantaro.m4a','b aru');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'patio.png','patio.m4a','atrjii');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'humo.png','humo.m4a','bipji');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'ceniza.png','ceniza.m4a','b uzibi');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'cajon.png','cajon.m4a','juaru');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'tortilla.png','tortilla.m4a','xedyi');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'sillon.png','sillon.m4a','minjii');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'techo.png','techo.m4a','nrrenzumu');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'piso.png','piso.m4a','ajomu');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'jarro.png','jarro.m4a','xalo');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'foto.png','foto.m4a',' jmicha');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'libro.png','libro.m4a','xiskuama');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'espejo.png','espejo.m4a','jñeje');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'jabon.png','jabon.m4a','shaboo');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'sacate.png','sacate.m4a','strmee');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'agua.png','agua.m4a','reje');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'cepillo.png','cepillo.m4a','dyese');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'regadera.png','regadera.m4a','pedye nreje');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'escoba.png','escoba.m4a','baxu');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'peine.png','peine.m4a','chesto');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'tabla.png','tabla.m4a','nrraxitchje');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'cama.png','cama.m4a','ñobbe');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'lampara.png','lampara.m4a','najuasu');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'buro.png','buro.m4a','kuatu');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'ventana.png','ventana.m4a','venrrana');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'escalera.png','escalera.m4a','dezhe');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'cobija.png','cobija.m4a','xidyo');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'ropa.png','ropa.m4a','bitu');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'bolsa.png','bolsa.m4a','mbuxa');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'dinero.png','dinero.m4a','mechi');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'sombrero.png','sombrero.m4a','chjunsu');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'zapato.png','zapato.m4a','dyesi');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'vela.png','vela.m4a','yhoo');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'luz.png','luz.m4a','jiasu');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'camisa.png','camisa.m4a','pajna');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'arete.png','arete.m4a','sukju');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'tijera.png','tijera.m4a','ñaxa');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'collar.png','collar.m4a','chjebe');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'faja.png','faja.m4a','mbuntru');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'aire.png','aire.m4a','nrajma');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'barranca.png','barranca.m4a','kotru');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'campo.png','campo.m4a','moo');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'camino.png','camino.m4a','ñii');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'leña.png','leña.m4a','zaa');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'lodo.png','lodo.m4a','mbejumu');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'luna.png','luna.m4a','zana');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'maiz.png','maiz.m4a','trjoo');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'nube.png','nube.m4a','ngoma');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'piedra.png','piedra.m4a','nrojo');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'pozo.png','pozo.m4a','tr oreje');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'rio.png','rio.m4a','nrareje');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'sol.png','sol.m4a','jyaru');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'raiz.png','raiz.m4a','dyuu');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'pueblo.png','pueblo.m4a','jñiñi');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'arcoiris.png','arcoiris.m4a','ngusibi');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'granizo.png','granizo.m4a','ngunrrojo');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'lluvia.png','lluvia.m4a','dyebe');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'trigo.png','trigo.m4a','nzhexu');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'estrella.png','estrella.m4a','seeje');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'pasto.png','pasto.m4a','phindyo');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'arbol.png','arbol.m4a','xiza');");
    await db.execute("INSERT INTO $tablaVocabulario VALUES(NULL,'flor.png','flor.m4a','nrrenzhajna');");
    // tipos de juegos

    await db.execute("INSERT INTO $tablaTipoJuego VALUES (NULL,'Selecciona la respuesta correcta','Quiz','espanol.png','espanol')");
    await db.execute("INSERT INTO $tablaTipoJuego VALUES (NULL,'Operaciones matematicas','Quiz','matematicas.png','matematicas')");
    await db.execute("INSERT INTO $tablaTipoJuego VALUES (NULL,'Aprende de ciencia','Quiz','ciencia.png','ciencias')");








  }
  Future<bool>insertNewUser(NewUser user) async {
    try{  
      final db =  await instance.dataBase;
       await db.insert(tablaUsaurios, user.toMap());
       return true;
    } on Exception{
      if (kDebugMode) {
        print('❌ ha ocurrido un error al insertar un nuevo usuario');
      }
      return false;
    }
  }

  Future<bool> validateUser(String nombre, String password)async{
    try{
      final db = await instance.dataBase;
      final result = await db.query(
        tablaUsaurios,
        columns: ['nombre_usuario'],
        where: 'nombre_usuario = ? and password_usuario=?',
        whereArgs:[nombre,password]
      );
      if(result.isNotEmpty){
        return true;
      }else{
        return false;
      }
    } on Exception{
      if (kDebugMode) {
        print('❌ ha ocurrido un error al validar el usuario');
      }
      return false;
    }
  }
  // ontiene la informacion de un usuario en especifico
  Future<User> getUserInfo(String nombre)async{
    try{
      final db = await instance.dataBase;
      final List<Map<String, dynamic>> userInfo =  await db.query(
        tablaUsaurios,
         columns: ['id_usuario','nombre_usuario','password_usuario'] ,
         where: 'nombre_usuario = ?',
         whereArgs: [nombre]
      );
      late User response;
      final List<User> convertion =  List.generate(userInfo.length, (index) {
        return User(
          id: userInfo[index]['id_usuario'], 
          nombre: userInfo[index]['nombre_usuario'], 
          password: userInfo[index]['password_usuario']
        );
      });
      for (var user in convertion) {
        response = User(
          id: user.id, 
          nombre: user.nombre, 
          password: user.password
        );
      }
      return response;
    } on Exception{
      if (kDebugMode) {
        print('❌ ha ocurrido un error al obtener la info del usuario.');
      }
      return User(id: -1, nombre: 'nombre', password: 'password');
    }
  }



  // obtiene la lista de categorias de los repasos

  Future<List<Categoria>> getCategoriaDeRepasos()async {
    final db  = await instance.dataBase;
    try {
      final List<Map<String,dynamic>> data = await db.query(tablaCategoria);
      final resultado = data.map((catergoria) => Categoria.fromMap(catergoria)).toList();
      return resultado;
    } on Exception {
      if (kDebugMode) {
        print('❌ ha ocurrido un error al obtener las categorias de repasos...');
      }
      return [];
    }
    
    
  }

  Future<List<Animales>> getAllAnimales()async {
    final db = await instance.dataBase;
    try {
      final List<Map<String,dynamic>> data = await db.query(tablaAnimales);
      final List<Animales> animales = data.map((animal) => Animales.fromMap(animal)).toList();
      return animales;
    } on Exception {
      if (kDebugMode) {
        print('❌ ocurrio un error al obtener los animales');
      }
      return [];
    }
  }

  Future<List<Numeros>> getAllNumeros()async{
    final db = await instance.dataBase;
    try {
      final List<Map<String,dynamic>> data =  await db.query(tablaNumeros);
      final List<Numeros> numeros = data.map((numero) => Numeros.fromMap(numero)).toList();
      return numeros;
    } on Exception {
      if (kDebugMode) {
        print('❌ ocurrio un error al obtener los numeros');
      }
      return [];
    }
  }

  Future<List<FrutasYverduras>> getAllFrutasYverduras()async{
    final db = await instance.dataBase;
    try {
      final List<Map<String,dynamic>> data =  await db.query(tablaFrutasYverduras);
      final List<FrutasYverduras> fv = data.map((fv) => FrutasYverduras.fromMap(fv)).toList();
      return fv;
    } on Exception {
      if (kDebugMode) {
        print('❌ ocurrio un error al obtener las frutas y verduras');
      }
      return [];
    }
  }


  Future<List<Colores>> getAllColores()async{
    final db = await instance.dataBase;
    try {
      final List<Map<String,dynamic>> data =  await db.query(tablaColores);
      final List<Colores> colores = data.map((color) => Colores.fromMap(color)).toList();
      return colores;
    } on Exception {
      if (kDebugMode) {
        print('❌ ocurrio un error al obtener los colores');
      }
      return [];
    }
  }

  Future<List<PartesDelCuerpo>> getAllPartesDelCuerpo()async{
    final db = await instance.dataBase;
    try {
      final List<Map<String,dynamic>> data =  await db.query(tablaPartesDelCuerpo);
      final List<PartesDelCuerpo> fv = data.map((pdc) => PartesDelCuerpo.fromMap(pdc)).toList();
      return fv;
    } on Exception {
      if (kDebugMode) {
        print('❌ ocurrio un error al obtener las frutas y verduras');
      }
      return [];
    }
  }

  Future<List<Niveles>> getNiveles()async{
    final db = await instance.dataBase;
    try {
      final List<Map<String,dynamic>> data = await db.query(tablaNiveles);
      final List<Niveles> niveles = data.map((nivel) => Niveles.fromMap(nivel)).toList();
      return niveles;
    }on Exception{
      if (kDebugMode) {
        print('❌Error al obtener los niveles');
      }
      return [];
    }
  }

  Future<List<Vocabulario>> getVocabulario()async{
    final db = await instance.dataBase;
    try {
      final List<Map<String,dynamic>> data = await db.query(tablaVocabulario);
      final List<Vocabulario> vocabulario = data.map((nivel) => Vocabulario.fromMap(nivel)).toList();
      return vocabulario;
    }on Exception{
      if (kDebugMode) {
        print('❌Error al obtener los niveles');
      }
      return [];
    }
  }


  Future<List<Preguntas>> getPreguntas()async{
    final db = await instance.dataBase;
    try {
      final List<Map<String,dynamic>> data = await db.query(tablaPreguntas);
      final List<Preguntas> preguntas = data.map((pregunta) => Preguntas.fromMap(pregunta)).toList();
      return preguntas;
    } on Exception {
      if (kDebugMode) {
        print('❌Error al obtener las preguntas');
      }
      return [];
    }
  }


  Future<List<TipoJuego>> getTiposDeJuegos()async{
    final db = await instance.dataBase;
    try {
      final List<Map<String,dynamic>> data = await db.query(tablaTipoJuego);
      final List<TipoJuego> tiposDeJuegos = data.map((juego) => TipoJuego.fromMap(juego)).toList();
      return tiposDeJuegos;
    } on Exception{
      if (kDebugMode) {
        print('❌ Ocurrio un error al obtener los tipos de juegos...');
      }
      return [];
    }
  }


  Future<List<OperacionesMatematicas>> getOperacionesMatematicas()async{
    final db = await instance.dataBase;
    try {
      final List<Map<String,dynamic>> data = await db.query(tablaJuegoMatematica);
      final List<OperacionesMatematicas> operacionesMatematicas = data.map((operacion) => OperacionesMatematicas.fromMap(operacion)).toList();
      return operacionesMatematicas;
    } on Exception {
      print('❌ Error al obtener las operaciones matematicas');
      return [];
    }
  }



}