

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazahua/src/domain/blocs/blocs.dart';
import 'package:mazahua/src/ui/pages/pages.dart';

class MyCard extends StatelessWidget {
  const MyCard({
    Key? key,
    this.width,
    this.height,
    this.color,
    this.borderRadius,
    this.image,
    required this.onClick,
  }) : super(key: key);

  final double? width;
  final double? height;
  final Color? color;
  final double? borderRadius;
  final String? image;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(),
      child: Container(
        decoration:  BoxDecoration(
          color: color ?? Colors.amber,
          borderRadius: BorderRadius.circular(borderRadius ?? 5.0)
        ),
        width: width ?? 50,
        height: height ?? 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder<JuegoMatematicaBloc, JuegoMatematicaState>(
              builder: (context, state) {
                if(image != null){
                 return Image.asset(image!,filterQuality: FilterQuality.high,);
                }else{
                  return const Placeholder(
                    strokeWidth: 1.0,
                    fallbackHeight: 200,
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}