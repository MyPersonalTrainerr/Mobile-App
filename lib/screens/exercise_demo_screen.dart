import 'package:flutter/material.dart';
import 'package:my_pt/value_notifiers/value_notifiers.dart';
import 'package:my_pt/widgets/demo.dart';
import 'package:my_pt/providers/exercises_provider.dart';
import 'package:provider/provider.dart';

class ExerciseDemoScreen extends StatefulWidget {
  static const routeName = '/exercise-details';

  @override
  State<ExerciseDemoScreen> createState() => _ExerciseDemoScreenState();
}

class _ExerciseDemoScreenState extends State<ExerciseDemoScreen> {
  @override
  Widget build(BuildContext context) {
    final exerciseData = Provider.of<ExercisesProvider>(context, listen: false);
    final exerciseId = ModalRoute.of(context)!.settings.arguments;
    final title = exerciseData.findItemById(exerciseId as String).title;
    if (exerciseId == 'w2') {
      exerciseNumber.value = '1';
    } else if (exerciseId == 'w4') {
      exerciseNumber.value = '2';
    } else if (exerciseId == 'w1') {
      exerciseNumber.value = '3';
    } else {
      exerciseNumber.value = '4';
    }

    final AppBar appBar = AppBar(
      title: Text(
        title,
      ),
    );
    // final double height = MediaQuery.of(context).size.height;
    // final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(child: Demo(exerciseId: exerciseId)),
    );
  }
}
