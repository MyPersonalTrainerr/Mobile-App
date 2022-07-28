import 'package:my_pt/providers/exercise_video_data.dart';
import 'package:my_pt/value_notifiers/value_notifiers.dart';
import 'package:my_pt/widgets/painter_widget.dart';
import 'package:my_pt/widgets/pullet.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Videoo extends StatefulWidget {
  const Videoo({Key? key}) : super(key: key);

  @override
  State<Videoo> createState() => _VideooState();
}

class _VideooState extends State<Videoo> {
  VideoPlayerController? _controller;
  VideoPlayerController? _toBeDisposed;
  double aspectRatio = 16 / 9;

  @override
  void deactivate() {
    if (_controller != null) {
      _controller!.setVolume(0.0);
      _controller!.pause();
    }
    super.deactivate();
  }

  @override
  void dispose() {
    _disposeVideoController();
    super.dispose();
  }

  Future<void> _disposeVideoController() async {
    if (_toBeDisposed != null) {
      await _toBeDisposed!.dispose();
    }
    _toBeDisposed = _controller;
    _controller = null;
  }

  Future<void> initVideoPlayer() async {
    try {
      _controller = VideoPlayerController.file(File(videoPath.value));
      var _initializedControllerFuture = await _controller!.initialize();
      _controller!.setLooping(false);
      setState(() {
        aspectRatio = _controller!.value.aspectRatio;
      });
      return _initializedControllerFuture;
    } catch (error) {
      print('error: $error');
    }
  }

  void _playVideo(File? file) {
    _controller!.play();
  }

  List<Widget> stringsToWidgets(List comments, double width) {
    List<Pullet> pulletsList = [];
    for (var c in comments) {
      pulletsList.add(Pullet(
        text: c,
        width: width,
      ));
    }
    return pulletsList;
  }

  @override
  Widget build(BuildContext context) {
    final videoData = Provider.of<ExcerciseVideoData>(context, listen: false);
    final double height = ((MediaQuery.of(context).size.width) / (aspectRatio) -
            AppBar().preferredSize.height) *
        0.8;
    final double width = (MediaQuery.of(context).size.width);
    return Scaffold(
      appBar: AppBar(title: Text('YOUR RESULTS')),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: videoData.getData(width, height, context),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              _playVideo(File(videoPath.value));
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: height,
                    width: width,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          child: AspectRatio(
                            aspectRatio: _controller!.value.aspectRatio,
                            child: VideoPlayer(_controller!),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: PainterWidget(
                            height: height,
                            width: width,
                          ),
                        )
                      ],
                    ),
                  ),
                  ValueListenableBuilder(
                      valueListenable: comments,
                      builder: (BuildContext context,
                          List<dynamic> commentsList, _) {
                        return Container(
                          padding: EdgeInsets.all(20),
                          child: Column(
                              children: stringsToWidgets(commentsList, width)),
                        );
                      })
                ],
              );
            }),
      ),
    );
  }
}
