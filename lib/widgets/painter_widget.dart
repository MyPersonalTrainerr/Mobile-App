import 'package:flutter/material.dart';
import 'package:my_pt/models/painter.dart';
import 'package:my_pt/value_notifiers/value_notifiers.dart';

class PainterWidget extends StatefulWidget {
  double height;
  double width;
  PainterWidget({Key? key, required this.height, required this.width})
      : super(key: key);

  @override
  State<PainterWidget> createState() => _PainterWidgetState();
}

class _PainterWidgetState extends State<PainterWidget> {
  @override
  void dispose() {
    // drawing.dispose();
    // frame.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('im here');
    // final double height = MediaQuery.of(context).size.height;
    // final double width = MediaQuery.of(context).size.width;
    return ValueListenableBuilder(
      valueListenable: frame,
      builder: (BuildContext context, List<Offset> _frame, __) {
        if (drawing.value) {
          return CustomPaint(
            child: Container(
                // width: widget.width,
                // height: widget.height,
                ),
            painter: ThePainter(
                _frame, angles.value, positions.value, comments.value),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
