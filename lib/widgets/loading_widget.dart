import 'package:flutter/material.dart';
import 'package:my_pt/widgets/color_loader.dart';

class LoadingWidget extends StatelessWidget {
  final String text;
  const LoadingWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(child: Center(child: ColorLoader())),

        // Padding(
        //   padding: EdgeInsets.all(10.0),
        //   child: Text(text,
        //       style: TextStyle(
        //         fontSize: 22,
        //         fontWeight: FontWeight.bold,
        //       )),
        // ),
      ],
    );
  }
}
