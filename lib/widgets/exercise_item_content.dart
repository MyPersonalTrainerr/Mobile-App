import 'package:flutter/material.dart';
import 'package:my_pt/providers/exercise.dart';

class ExerciseItemContent extends StatefulWidget {
  final Exercise exerciseData;
  ExerciseItemContent(this.exerciseData, {Key? key}) : super(key: key);

  @override
  State<ExerciseItemContent> createState() => _ExerciseItemContentState();
}

class _ExerciseItemContentState extends State<ExerciseItemContent> {
  // Future<void> _loadImage(){
  // }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Card(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      // elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Stack(
        children: <Widget>[
          Container(
            // margin: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            height: height * 0.25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),

            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                widget.exerciseData.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            // margin: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color.fromRGBO(0, 0, 0, .3),
              //  color: Color.fromRGBO(143, 148, 251, 0.4),
            ),
            height: height * 0.25,
          ),
          Positioned(
            bottom: widget.exerciseData.bottom,
            left: widget.exerciseData.left,
            child: Container(
              width: 300,
              child: Text(
                widget.exerciseData.title,
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
                softWrap: true,
                overflow: TextOverflow.fade,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
