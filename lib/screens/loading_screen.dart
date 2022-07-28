import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_pt/providers/exercise_video_data.dart';
import 'package:my_pt/widgets/video_display.dart';
import 'package:my_pt/value_notifiers/value_notifiers.dart';
import 'package:my_pt/widgets/loading_widget.dart';
import 'package:provider/provider.dart';
import 'package:my_pt/models/error.dart';

class LoadingScreen extends StatefulWidget {
  static const routeName = '/loading';
  LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool pollingState = false;
  bool second = false;
  bool error = false;

  @override
  Widget build(BuildContext context) {
    final videoData = Provider.of<ExcerciseVideoData>(context, listen: false);
    final AppBar appBar = AppBar(
      title: const Text(
        "YOUR RESULTS",
      ),
    );

    return Scaffold(
        appBar: appBar,
        body: FutureBuilder(
          future: videoData.postExercise(exerciseNumber.value),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.data == 'success') {
              return FutureBuilder(
                future: videoData.uploadFile(File(videoPath.value)),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  print(videoPath.value);
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: LoadingWidget());
                  }
                  if (snapshot.connectionState == ConnectionState.done &&
                      videoUploaded.value) {
                    return ValueListenableBuilder(
                        valueListenable: statusNotifier,
                        builder: (BuildContext context, String status, _) {
                          print(status);
                          if (status == '0') pollingState = true;
                          if (status == '1' && pollingState) {
                            return const VideoDisplay();
                            // Navigator.of(context).pushReplacement(
                            //   MaterialPageRoute<void>(
                            //     builder: (BuildContext context) => VideoScreen(),
                            //   ),
                            // );
                          }
                          return const Center(child: LoadingWidget());
                        });
                  } else {
                    // Error.showErrorDialog(
                    //     "Check your internet connection and try again.", context);
                    // _scaffoldKey.currentState!.showSnackBar(SnackBar(
                    //   content: Text("Check your internet connection and try again."),
                    // ));
                    return Container(child: Text('sth went wrong'));
                  }
                },
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: LoadingWidget());
            } else {
              return Center(
                  child: Text('Something went wrong. Please try again.'));
            }
          },
        ));
  }
}
