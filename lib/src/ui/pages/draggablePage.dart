// ignore_for_file: file_names

import 'package:mazahua/src/ui/pages/pages.dart';

class DragabblePage extends StatelessWidget {
  const DragabblePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Draggable widget'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            height: size.height * 0.45,
            //margin: const EdgeInsets.only(top:12.0),
            decoration: const BoxDecoration(
              //color: Colors.green,
              image: DecorationImage(
                alignment: Alignment.topCenter,
                image: AssetImage('assets/backgrounds/juego_ciencias/juego_ciencias.png')
              )
            ),
          ),
          // Draggable(
          //   child: Container(
          //     color: Colors.amber,
          //     height: 60,
          //     width: 60,
          //     child: const Text('HOLA'),
          //   ), 
          //   feedback: Container(
          //     color: Colors.red,
          //     height: 60,
          //     width: 60,
          //     child: const Text('HOLA'),
          //   ), 
          // )
          SizedBox(
            height: size.height * 0.45,
            //color: Colors.transparent.withOpacity(0.2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: size.width,
                        //color: Colors.red.withOpacity(0.3),
                        child: Column(
                          children: [
                            SizedBox(
                              height: size.height * 0.45,
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: -5,
                                    left: 7,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        color: Colors.amber.withOpacity(0.8),
                                      ),
                                      height: size.height * 0.07,
                                      margin: const EdgeInsets.all(5.0),
                                      width: size.width * 0.15,
                                      child: const Center(child: Text('data')),
                                    ),
                                  ),
                                  Positioned(
                                    top: -5,
                                    right: 10,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        color: Colors.amber.withOpacity(0.8),
                                      ),
                                      height: size.height * 0.07,
                                      margin: const EdgeInsets.all(5.0),
                                      width: size.width * 0.15,
                                      child: const Center(child: Text('data')),
                                    ),
                                  ),
                                  Positioned(
                                    top: (-5+85),
                                    left: 7,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        color: Colors.green.withOpacity(0.8),
                                      ),
                                      height: size.height * 0.07,
                                      margin: const EdgeInsets.all(5.0),
                                      width: size.width * 0.15,
                                      child: const Center(child: Text('data')),
                                    ),
                                  ),
                                  Positioned(
                                    top: 78,
                                    right: 10,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        color: Colors.green.withOpacity(0.8),
                                      ),
                                      height: size.height * 0.07,
                                      margin: const EdgeInsets.all(5.0),
                                      width: size.width * 0.15,
                                      child: const Center(child: Text('data')),
                                    ),
                                  ),
                                  Positioned(
                                    top: 78+85,
                                    left: 7,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        color: Colors.blue.withOpacity(0.8),
                                      ),
                                      height: size.height * 0.07,
                                      margin: const EdgeInsets.all(5.0),
                                      width: size.width * 0.15,
                                      child: const Center(child: Text('data')),
                                    ),
                                  ),
                                  Positioned(
                                    top: (78+85),
                                    right: 10,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        color: Colors.blue.withOpacity(0.8),
                                      ),
                                      height: size.height * 0.07,
                                      margin: const EdgeInsets.all(5.0),
                                      width: size.width * 0.15,
                                      child: const Center(child: Text('data')),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 98,
                                    left: 7,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        color: Colors.red.withOpacity(0.8),
                                      ),
                                      height: size.height * 0.07,
                                      margin: const EdgeInsets.all(5.0),
                                      width: size.width * 0.15,
                                      child: const Center(child: Text('data')),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 98,
                                    right: 10,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        color: Colors.red.withOpacity(0.8),
                                      ),
                                      height: size.height * 0.07,
                                      margin: const EdgeInsets.all(5.0),
                                      width: size.width * 0.15,
                                      child: const Center(child: Text('data')),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 15,
                                    left: 7,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        color: Colors.indigo.withOpacity(0.8),
                                      ),
                                      height: size.height * 0.07,
                                      margin: const EdgeInsets.all(5.0),
                                      width: size.width * 0.15,
                                      child: const Center(child: Text('data')),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 15,
                                    right: 10,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        color: Colors.indigo.withOpacity(0.8),
                                      ),
                                      height: size.height * 0.07,
                                      margin: const EdgeInsets.all(5.0),
                                      width: size.width * 0.15,
                                      child: const Center(child: Text('data')),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          )
        ],
      )
    );
  }
}