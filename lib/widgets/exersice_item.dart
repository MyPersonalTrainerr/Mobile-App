import 'package:flutter/material.dart';
import 'package:my_pt/providers/exercise.dart';
import 'package:my_pt/screens/exercise_demo_screen.dart';
import 'package:my_pt/widgets/exercise_item_content.dart';
import 'package:provider/provider.dart';

class ExerciseItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final exerciseData = Provider.of<Exercise>(context, listen: false);

    return ChangeNotifierProvider.value(
      value: exerciseData,
      child: InkWell(
        onTap: () => Navigator.of(context).pushNamed(
            ExerciseDemoScreen.routeName,
            arguments: exerciseData.id),
        child: ExerciseItemContent(exerciseData),
      ),
    );
  }
}
