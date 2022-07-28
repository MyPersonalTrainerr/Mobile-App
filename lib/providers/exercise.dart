import 'package:flutter/material.dart';

class Exercise with ChangeNotifier {
  final String id;
  final String title;
  final String imageUrl;
  double left;
  double bottom;

  Exercise({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.bottom,
    required this.left,
  });
}
