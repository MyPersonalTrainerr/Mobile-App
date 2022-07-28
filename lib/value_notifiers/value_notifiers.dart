import 'package:flutter/material.dart';

ValueNotifier<bool> drawing = ValueNotifier(false);
ValueNotifier<List<Offset>> frame = ValueNotifier([]);
ValueNotifier<List<dynamic>> angles = ValueNotifier([]);
ValueNotifier<List<dynamic>> positions = ValueNotifier([]);
ValueNotifier<List<dynamic>> comments = ValueNotifier([]);
ValueNotifier<List<dynamic>> squats = ValueNotifier([]);
ValueNotifier<bool> videoUploaded = ValueNotifier(false); //ok
ValueNotifier<String> statusNotifier = ValueNotifier('1'); //status
ValueNotifier<String> videoPath = ValueNotifier('');
ValueNotifier<String> exerciseNumber = ValueNotifier('1');
