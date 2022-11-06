

import 'package:flutter/material.dart';

class MyButtom extends StatelessWidget {

  final Color color;
  final String text;
  final double borderRadius;
  final Function onClick;
  final double? minWidth;
  final double? height;
  final Color? textColor;
  const MyButtom({
      Key? key,
      required this.color,
      required this.text,
      required this.borderRadius,
      required this.onClick,
      this.minWidth,
      this.height,
      this.textColor
    }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height,
      minWidth: minWidth,
      onPressed: ()=> onClick(),
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius)
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor ?? Colors.black87,
          
        ),
        maxLines: 1,
        
      ),
    );
  }

}