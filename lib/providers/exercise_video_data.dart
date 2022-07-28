import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_pt/value_notifiers/value_notifiers.dart';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';

class ExcerciseVideoData with ChangeNotifier {
  Future<dynamic> uploadFile(File file) async {
    var uri = Uri.parse('http://192.168.1.9:8000/fileUploadApi/');
    try {
      var filename = file.path;
      var request = http.MultipartRequest('POST', uri);
      request.files
          .add(await http.MultipartFile.fromPath('file_uploaded', filename));
      var response = await request.send();
      if (response.reasonPhrase == 'OK') {
        videoUploaded.value = true;
      }
      return response.reasonPhrase;
    } catch (error) {
      print('error: $error');
      rethrow;
    }
  }

  Future<dynamic> postExercise(String exerciseNumber) async {
    var uri = Uri.parse('http://192.168.1.9:8000/postExercise/');
    try {
      var response = await http.post(uri, body: {'exercise': exerciseNumber});
      var responsePhrase = json.decode(response.body);
      print('response: ${responsePhrase['status']}');
      return responsePhrase['status'];
    } catch (error) {
      print('error: $error');
    }
  }

  Future<void> getStatus() async {
    var uri = Uri.parse('http://192.168.1.9:8000/getStatus/');
    while (true) {
      try {
        var statusResponse = await http.get(uri);
        var status = statusResponse.body;
        statusNotifier.value = status;
        // print('status: $status');
      } catch (error) {
        print('error: $error');
        rethrow;
      }
    }
  }

  Future<void> getData(
    double width,
    double height,
    BuildContext context,
  ) async {
    try {
      List<Offset> jsonList = [];
      List<List<dynamic>> anglesList = [];
      List<List<dynamic>> positionsList = [];
      List<List<dynamic>> commentsList = [];
      List<List<dynamic>> squatsNumber = [];
      drawing.value = true;
      String path =
          "E:/Flutter/Projects/my_pt/Backend/env/Backend/MyPersonalTrainer/Points.json";

      String data = await DefaultAssetBundle.of(context).loadString(path);
      var jsonData = await json.decode(data);
      jsonData.forEach((frame) {
        frame.forEach((point, value) {
          if (point == 'Angles') {
            anglesList.add(value);
          } else if (point == 'Positions') {
            positionsList.add(value);
          } else if (point == 'comments') {
            commentsList.add(value);
          } else if (point == 'squats') {
            squatsNumber.add(value);
          } else {
            var globalPos = Offset((value[0] + 15).toDouble(),
                (value[1] * (width / height)).toDouble());
            jsonList.add(globalPos);
          }
        });
      });
      print('legnth of data is ${jsonData.length}');
      var remaining = jsonList.length;
      frame.value.clear();
      List<Offset> currentFrame;
      for (int i = 0, c = 0;
          i < jsonList.length && c < anglesList.length;
          i = i + 33, c++) {
        currentFrame = [];
        for (var j = i; j <= (i + 32); j++) {
          if (remaining < 32) {
            for (var k = 0; k < remaining; k++) {
              currentFrame.add(jsonList[k]);
            }
          } else {
            currentFrame.add(jsonList[j]);
          }
        }
        frame.value = currentFrame;
        angles.value = anglesList[c];
        positions.value = positionsList[c];
        commentsList[c].forEach((element) {
          comments.value.add(element);
        });
        squats.value = squatsNumber[c];
        remaining = remaining - 32;

        await Future.delayed(Duration(milliseconds: 30));
      }
      drawing.value = false;
      frame.value.clear();
    } catch (error) {
      print('error: $error');
      rethrow;
    }
  }
}
