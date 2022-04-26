import 'package:flutter/material.dart';

class GradientBack extends StatelessWidget {

  String tittle = '';
  double? heightNab; 
  
  GradientBack({Key? key, required this.tittle , this.heightNab}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var list = [Theme.of(context).primaryColorDark, Theme.of(context).primaryColorLight];

    heightNab = heightNab ?? MediaQuery.of(context).size.height;
    return Container(
      height: heightNab,
      decoration:  BoxDecoration(
        gradient: LinearGradient(
          colors: list,
        begin: const FractionalOffset(0.2, 0.0),
        end: const FractionalOffset(1.0, 0.6),
        stops: const [0.0, 0.6,],
        tileMode: TileMode.clamp 
        )
      ),
      child: FittedBox(
        fit: BoxFit.none,
        alignment: const Alignment(-1.5,-0.8),
        child: Container(
          height: heightNab ,
          width: MediaQuery.of(context).size.width+450,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(251, 209, 25, 0.11),
            borderRadius:  BorderRadius.circular(heightNab! / 2.toDouble())
          ),
        ),
      ),
      
    );
  }
}