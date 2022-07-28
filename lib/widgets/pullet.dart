import 'package:flutter/material.dart';

class Pullet extends StatelessWidget {
  String text;
  double width;
  Pullet({Key? key, required this.text, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Icon(Icons.fitness_center),
          ),
          Flexible(
              child: Text(
            text,
            softWrap: true,
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
        ],
      ),
    );
  }
}
