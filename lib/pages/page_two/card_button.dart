import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardButton extends StatefulWidget {
  String textDescription = 'Nuevo';
  String picture = '';
  final VoidCallback onPressed;

  CardButton(
      {Key? key,
      required this.textDescription,
      required this.onPressed,
      required this.picture})
      : super(key: key);

  @override
  State<CardButton> createState() => _CardButtonState();
}

class _CardButtonState extends State<CardButton> {
  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxHeight: 200,
      child: MaterialButton(
        onPressed: widget.onPressed,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(widget.picture),
                ),
                borderRadius: const BorderRadius.all(Radius.circular(25)),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
              child: Container(
                height: 50,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(166, 66, 74, 65),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Center(
                  child: Text(
                    widget.textDescription,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
