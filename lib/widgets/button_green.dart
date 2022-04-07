import 'package:flutter/material.dart';

class ButtonGreen extends StatefulWidget {

  final String text;
  double width = 0.0;
  double height = 0.0;
  VoidCallback onPressed;

  ButtonGreen( this.text, this.onPressed ,this.width, this.height, {Key? key}) : super(key: key);

  @override
  State<ButtonGreen> createState() => _ButtonGreenState();
}

class _ButtonGreenState extends State<ButtonGreen> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:widget.onPressed,
      child: Container(
        margin: const EdgeInsets.only(
          top: 30.0,
          left: 20.0,
          right: 20.0
        ),
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13.0),
          gradient: const LinearGradient(
            colors:  [
              Color.fromRGBO(24, 78, 119, 84),
              Color.fromRGBO(118, 200, 147,1),            
            ],
            begin: FractionalOffset(0.2,0.0),
            end: FractionalOffset(1.2,0.8),
            stops: [0.1,0.8],
            tileMode: TileMode.clamp
          )
        ),
        child: Center(
          child: Text(
            widget.text,
            style: const TextStyle(
              fontSize: 18.0,
              fontFamily: "Lato",
              color: Colors.white
            )
          ),
        ),
      ),
      
      
    );
  }
}