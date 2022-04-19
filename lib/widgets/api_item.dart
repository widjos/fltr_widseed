import 'package:flutter/material.dart';

class ApiItem extends StatelessWidget {
  final double maxHeight;
  final double fontSize;
  final String name;
  final String value;

  ApiItem(
      {Key? key,
      required this.maxHeight,
      required this.fontSize,
      required this.name,
      required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
        maxHeight: maxHeight,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 10, left: 25, bottom: 15),
              width: 158,
              child: Text(
                name,
                style: Theme.of(context).textTheme.bodyText1//TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, style: Theme.of(context).textTheme),
                
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10, left: 25, bottom: 15),
              child: Text(
                value,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ],
        ));
  }
}
