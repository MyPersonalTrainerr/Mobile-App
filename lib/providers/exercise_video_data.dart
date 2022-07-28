// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:my_pt/value_notifiers/value_notifiers.dart';
// import 'dart:convert';

// import 'package:path_provider/path_provider.dart';

// class ExcerciseVideoData with ChangeNotifier {
//   Future<dynamic> uploadFile(File file) async {
//     var uri = Uri.parse('http://192.168.1.9:8000/fileUploadApi/');
//     // var uri = Uri.parse('http://awatef.pythonanywhere.com/fileUploadApi/');
//     try {
//       var filename = file.path;
//       var request = http.MultipartRequest('POST', uri);
//       request.files
//           .add(await http.MultipartFile.fromPath('file_uploaded', filename));
//       var response = await request.send();
//       // if (response.reasonPhrase == 'OK') {
//       // videoUploaded.value = true;
//       // }
//       print('response: ${response.statusCode}');
//       // return response.reasonPhrase;
//     } catch (error) {
//       print('error: $error');
//       rethrow;
//     }
//   }

//   Future<dynamic> postExercise(String exerciseNumber) async {
//     var uri = Uri.parse('http://192.168.1.9:8000/postExercise/');
//     try {
//       var response = await http.post(uri, body: {'exercise': exerciseNumber});
//       var responsePhrase = json.decode(response.body);
//       print('response: ${responsePhrase['status']}');
//       return responsePhrase['status'];
//     } catch (error) {
//       print('error: $error');
//     }
//   }

//   // Future<void> getStatus() async {
//   //   var uri = Uri.parse('http://192.168.1.9:8000/getStatus/');
//   //   while (true) {
//   //     try {
//   //       var statusResponse = await http.get(uri);
//   //       var status = statusResponse.body;
//   //       statusNotifier.value = status;
//   //       // print('status: $status');
//   //     } catch (error) {
//   //       print('error: $error');
//   //       rethrow;
//   //     }
//   //   }
//   // }

//   Future<String> get _localPath async {
//     final directory = await getApplicationDocumentsDirectory();
//     print(directory.path);
//     return directory.path;
//   }

//   Future<File> get _localFile async {
//     final path = await _localPath;
//     print('path ${path}');
//     return File('$path/counter.txt');
//   }

//   Future<void> getData(
//     double width,
//     double height,
//     BuildContext context,
//   ) async {
//     try {
//       List<Offset> jsonList = [];
//       List<List<dynamic>> anglesList = [];
//       List<List<dynamic>> positionsList = [];
//       List<List<dynamic>> commentsList = [];
//       drawing.value = true;
//       // String path =
//       // "E:/Flutter/Projects/my_pt/Backend/env/Backend/MyPersonalTrainer/Points.json";
//       // "E:/Flutter/Projects/my_pt/django_m/env/Backend/MyPersonalTrainer/Points.json";

//       // String data = await DefaultAssetBundle.of(context).loadString(path);
//       // var jsonData = await json.decode(data);
//       jsonData.value[0].forEach((frame) {
//         frame.forEach((point, value) {
//           // print(point);
//           // print(value);
//           if (point == 'Angles') {
//             // print('Angles');
//             anglesList.add(value);
//           } else if (point == 'Positions') {
//             // print('Positions');
//             positionsList.add(value);
//           } else if (point == 'comments') {
//             // print('comments');
//             commentsList.add(value);
//           } else {
//             // print('positions');
//             var globalPos = Offset((value[0] + 15).toDouble(),
//                 (value[1] * (width / height) - 33).toDouble());
//             jsonList.add(globalPos);
//           }
//         });
//       });
//       print('legnth of data is ${jsonData.value.length}');
//       // print("Json list is $jsonList");
//       // print('state list is: $colors');
//       // var frameRate = videoDuration / (jsonData.length);
//       var remaining = jsonList.length;
//       frame.value.clear();
//       List<Offset> currentFrame;
//       for (int i = 0, c = 0;
//           i < jsonList.length && c < anglesList.length;
//           i = i + 33, c++) {
//         // for (int i = 0; i < jsonList.length; i = i + 33) {
//         currentFrame = [];
//         for (var j = i; j <= (i + 32); j++) {
//           if (remaining < 32) {
//             for (var k = 0; k < remaining; k++) {
//               currentFrame.add(jsonList[k]);
//             }
//           } else {
//             currentFrame.add(jsonList[j]);
//           }
//         }
//         frame.value = currentFrame;
//         angles.value = anglesList[c];
//         positions.value = positionsList[c];
//         comments.value = commentsList[c];
//         remaining = remaining - 32;
//         print("Frame list in get function ${frame.value}");
//         print("Angles list in get function ${angles.value}");
//         print("Positions list in get function ${positions.value}");
//         print("Comments list in get function ${comments.value}");

//         // print('aho: ${(frameRate).toInt()}');
//         await Future.delayed(Duration(milliseconds: 30));
//       }
//       drawing.value = false;
//       frame.value.clear();
//       // File jsonFile = File(path);
//       // var result = await _localFile;
//       // var deleteResult = await jsonFile.delete();
//       // print('delete: $deleteResult');
//       // jsonFile.writeAsString('');
//     } catch (error) {
//       print('error: $error');
//       rethrow;
//     }
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_pt/value_notifiers/value_notifiers.dart';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';

class ExcerciseVideoData with ChangeNotifier {
  Future<dynamic> uploadFile(File file) async {
    var uri = Uri.parse('http://192.168.1.9:8000/fileUploadApi/');
    // var uri = Uri.parse('http://awatef.pythonanywhere.com/fileUploadApi/');
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

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    print(directory.path);
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    print('path ${path}');
    return File('$path/counter.txt');
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
          "E:/Flutter/Projects/my_pt/test.json";
      // "E:/Flutter/Projects/my_pt/django_m/env/Backend/MyPersonalTrainer/Points.json";

      String data = await DefaultAssetBundle.of(context).loadString(path);
      var jsonData = await json.decode(data);
      jsonData.forEach((frame) {
        frame.forEach((point, value) {
          // print(point);
          // print(value);
          if (point == 'Angles') {
            print('Angles');
            anglesList.add(value);
          } else if (point == 'Positions') {
            print('Positions');
            positionsList.add(value);
          } else if (point == 'comments') {
            print('comments');
            commentsList.add(value);
          } else if (point == 'squats') {
            print('squats');
            squatsNumber.add(value);
          } else {
            // print('positions');
            var globalPos = Offset((value[0] + 15).toDouble(),
                (value[1] * (width / height) ).toDouble());
            jsonList.add(globalPos);
          }
        });
      });
      print('legnth of data is ${jsonData.length}');
      // print("Json list is $jsonList");
      // print('state list is: $colors');
      // var frameRate = videoDuration / (jsonData.length);
      var remaining = jsonList.length;
      frame.value.clear();
      List<Offset> currentFrame;
      for (int i = 0, c = 0;
          i < jsonList.length && c < anglesList.length;
          i = i + 33, c++) {
        // for (int i = 0; i < jsonList.length; i = i + 33) {
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
        comments.value = commentsList[c];
        squats.value = squatsNumber[c];
        remaining = remaining - 32;
        print("Frame list in get function ${frame.value}");
        print("Angles list in get function ${angles.value}");
        print("Positions list in get function ${positions.value}");
        print("Comments list in get function ${comments.value}");
        print("Squats list in get function ${squats.value}");

        // print('aho: ${(frameRate).toInt()}');
        await Future.delayed(Duration(milliseconds: 30));
      }
      drawing.value = false;
      frame.value.clear();
      // File jsonFile = File(path);
      // var result = await _localFile;
      // var deleteResult = await jsonFile.delete();
      // print('delete: $deleteResult');
      // jsonFile.writeAsString('');
    } catch (error) {
      print('error: $error');
      rethrow;
    }
  }
}
