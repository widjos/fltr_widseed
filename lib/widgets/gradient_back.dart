import 'package:flutter/material.dart';

class GradientBack extends StatelessWidget {

  String tittle = '';
  double? heightNab; 
  
  GradientBack({Key? key, required this.tittle , this.heightNab}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    heightNab = heightNab ?? MediaQuery.of(context).size.height;
    return Container(
      height: heightNab,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(163, 9, 121, 28),
            Color.fromARGB(255, 187, 255, 0)
          ],
        begin: FractionalOffset(0.2, 0.0),
        end: FractionalOffset(1.0, 0.6),
        stops: [0.0, 0.6,],
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
      
      
       /*Text(
        tittle,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 30.0,
          fontFamily: "Lato",
          fontWeight: FontWeight.bold
        )
      ),*/
      //alignment: const Alignment(-0.9,-0.6),

    );
  }
}