import 'package:flutter/material.dart';

class ButtonIcon extends StatefulWidget {
  
  final VoidCallback onPressed;
  bool mini;
  var icon;
  double iconSize;
  var color;

  ButtonIcon( this.mini, this.icon, this.iconSize, this.color,  this.onPressed );


  @override
  State<ButtonIcon> createState() => _ButtonIconState();
}

class _ButtonIconState extends State<ButtonIcon> {


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        mini: widget.mini,
        onPressed: widget.onPressed,
        child: Icon(
          widget.icon,
          size: widget.iconSize,
          color: Colors.white,
        ),
        heroTag: null,
      ),
      
    );
  }
}