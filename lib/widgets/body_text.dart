
import 'package:flutter/material.dart';


class BodyText extends StatelessWidget {
  const BodyText({ Key? key, 
  required this.color,
  required this.size,
  this.overflow= TextOverflow.ellipsis,
  required this.text,
  required this.weight,
  this.align = TextAlign.start
  }) 
  
  : super(key: key);

  final Color color;
  final String text;
  final double size;
  final TextOverflow overflow;
  final FontWeight weight;
  final TextAlign align;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
        fontFamily: 'Euclid',
        fontSize: size,
        fontWeight: weight,
        letterSpacing: 0.5,
        height: 1.5,
        color: color
      ),
    );
  }
}