import 'package:flutter/material.dart';
import 'package:my_pt/providers/exercise.dart';

class ExercisesProvider with ChangeNotifier {
  final List<Exercise> _items = [
    Exercise(
        id: 'w1',
        title: 'PULSE SQUAT',
        imageUrl: 'images/pulse_squat.webp',
        bottom: 100,
        left: 50),
    Exercise(
        id: 'w2',
        title: 'WALL SQUAT',
        imageUrl: 'images/wall_squat.jpg',
        bottom: 100,
        left: 50),
    Exercise(
        id: 'w3',
        title: 'DEEP SQUAT',
        imageUrl: 'images/deep_squat.jpg',
        bottom: 100,
        left: 50),
    Exercise(
        id: 'w4',
        title: 'STANDARD SQUAT',
        imageUrl: 'images/regular_squat.jpg',
        bottom: 100,
        left: 50),
  ];

  List<Exercise> get items {
    return [..._items];
  }

  Exercise findItemById(String exerciseId) {
    return _items.firstWhere((item) => item.id == exerciseId);
  }
}
