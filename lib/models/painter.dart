import "package:flutter/material.dart";

class ThePainter extends CustomPainter {
  List<Offset> offsets;
  List<dynamic> angles;
  List<dynamic> positions;
  List<dynamic> comments;
  ThePainter(this.offsets, this.angles, this.positions, this.comments)
      : super();

  @override
  void paint(Canvas canvas, Size size) {
    try {
      const double radius = 1;
      final paint = Paint()
        ..color = Color.fromRGBO(143, 148, 251, 0.5)
        ..strokeWidth = 3
        ..style = PaintingStyle.stroke;
      final paint2 = Paint()
        ..color = Color.fromRGBO(255, 0, 0, 0.5)
        ..strokeWidth = 3
        ..style = PaintingStyle.stroke;

      final paint3 = Paint()
        ..color = Color.fromRGBO(143, 148, 251, 0.5)
        ..strokeWidth = 5
        ..style = PaintingStyle.stroke;

      if (angles[0] == 0) {
        canvas.drawLine(
            offsets[24], offsets[26], paint2); //upper right leg wrong
        canvas.drawLine(
            offsets[23], offsets[25], paint2); //upper left leg wrong

      } else if (angles[0] == 1 || angles[0] == 2) {
        canvas.drawLine(
            offsets[24], offsets[26], paint); //upper right leg right
        canvas.drawLine(offsets[23], offsets[25], paint); //upper left leg right
      }

      if (angles[1] == 0) {
        canvas.drawLine(offsets[11], offsets[23], paint2); //back wrong
        canvas.drawLine(offsets[12], offsets[24], paint2); //back wrong

      } else if (angles[1] == 1 || angles[1] == 2) {
        canvas.drawLine(offsets[11], offsets[23], paint); //back right
        canvas.drawLine(offsets[12], offsets[24], paint); //back right
      }

      if (positions[0] == 0) {
        //knee wrong
        canvas.drawCircle(offsets[25], radius, paint2); //left wrong
        canvas.drawCircle(offsets[26], radius, paint2); //right wrong
      } else if (positions[0] == 1 || positions[0] == 2) {
        //knee right
        canvas.drawCircle(offsets[25], radius, paint3); //left
        canvas.drawCircle(offsets[26], radius, paint3); //right
      }

      if (positions[1] == 0) {
        //hip wrong
        canvas.drawCircle(offsets[23], radius, paint2); //hip left
        canvas.drawCircle(offsets[24], radius, paint2); //hip right
      } else if (positions[1] == 1 || positions[1] == 2) {
        //hip right
        canvas.drawCircle(offsets[23], radius, paint3); //hip left
        canvas.drawCircle(offsets[24], radius, paint3); //hip right
      }

      canvas.drawCircle(offsets[11], radius, paint3);
      canvas.drawCircle(offsets[12], radius, paint3);
      canvas.drawCircle(offsets[13], radius, paint3);
      canvas.drawCircle(offsets[14], radius, paint3);
      canvas.drawCircle(offsets[15], radius, paint3);
      canvas.drawCircle(offsets[16], radius, paint3);
      canvas.drawCircle(offsets[17], radius, paint3);
      canvas.drawCircle(offsets[18], radius, paint3);
      canvas.drawCircle(offsets[19], radius, paint3);
      canvas.drawCircle(offsets[20], radius, paint3);
      canvas.drawCircle(offsets[21], radius, paint3);
      canvas.drawCircle(offsets[22], radius, paint3);
      canvas.drawCircle(offsets[27], radius, paint3);
      canvas.drawCircle(offsets[28], radius, paint3);
      canvas.drawCircle(offsets[29], radius, paint3);
      canvas.drawCircle(offsets[30], radius, paint3);
      canvas.drawCircle(offsets[31], radius, paint3);
      canvas.drawCircle(offsets[32], radius, paint3);

      canvas.drawLine(offsets[26], offsets[28], paint); //lower right leg
      canvas.drawLine(offsets[25], offsets[27], paint); //lower left leg
      canvas.drawLine(offsets[20], offsets[18], paint);
      canvas.drawLine(offsets[18], offsets[16], paint);
      canvas.drawLine(offsets[16], offsets[22], paint);
      canvas.drawLine(offsets[16], offsets[20], paint);
      canvas.drawLine(offsets[16], offsets[14], paint);
      canvas.drawLine(offsets[14], offsets[12], paint);
      canvas.drawLine(offsets[12], offsets[11], paint);
      canvas.drawLine(offsets[24], offsets[23], paint);
      canvas.drawLine(offsets[28], offsets[30], paint);
      canvas.drawLine(offsets[28], offsets[32], paint);
      canvas.drawLine(offsets[32], offsets[30], paint);
      canvas.drawLine(offsets[11], offsets[13], paint);
      canvas.drawLine(offsets[13], offsets[15], paint);
      canvas.drawLine(offsets[15], offsets[21], paint);
      canvas.drawLine(offsets[15], offsets[17], paint);
      canvas.drawLine(offsets[17], offsets[19], paint);
      canvas.drawLine(offsets[19], offsets[15], paint);
      canvas.drawLine(offsets[27], offsets[29], paint);
      canvas.drawLine(offsets[27], offsets[31], paint);
      canvas.drawLine(offsets[29], offsets[31], paint);
    } catch (error) {
      print('error: $error');
      rethrow;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
