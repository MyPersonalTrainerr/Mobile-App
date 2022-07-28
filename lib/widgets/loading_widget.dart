import 'package:flutter/material.dart';
import 'package:my_pt/widgets/color_loader.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(child: Center(child: ColorLoader())),
      ],
    );
  }
}
