import 'package:flutter/material.dart';
import 'package:test/pages/sinister/page_sinister.dart';

class AlertIcon extends StatefulWidget {

  String title;
  String alert;
  AlertIcon({ Key? key, required this.title, required this.alert }) : super(key: key);

  @override
  State<AlertIcon> createState() => _AlertIconState();
}

class _AlertIconState extends State<AlertIcon> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Expanded(
        
        child: Text(widget.alert),
        
      ),
      actions: [
        TextButton(onPressed: (){
           Navigator.pop(context);
                      
        }, child: const Text('Ok'))
      ],
      
    );
  }
}