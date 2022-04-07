import 'package:flutter/material.dart';

class PageTwo extends StatelessWidget {
  final String tittle;
  const PageTwo({required this.tittle, Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title:  Text(this.tittle),
      ),
      
    );
  }
}