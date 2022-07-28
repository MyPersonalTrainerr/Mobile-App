import 'dart:typed_data';

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
  bool _isPlaying = false;
  Duration? _duration;
  Duration? _position;
  bool _isEnd = false;
  double videoDurtion = 0;
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
        //     _duration = _controller!.value.duration;
      });
      // print(videoPath.value);

      return _initializedControllerFuture;
    } catch (error) {
      print('error: $error');
    }
  }

  void _playVideo(File? file) {
    _controller!.play();
  }

  Future<void> _onImageButtonPressed(ImageSource source, double height,
      double width, BuildContext context) async {
    XFile? _file;
    final ImagePicker _picker = ImagePicker();

    _file = await _picker.pickVideo(
        source: source, maxDuration: const Duration(seconds: 10));
    videoPath.value = _file!.path;
    await initVideoPlayer();
    setState(() {});
  }

  List<Widget> commentsWidgetList = [];
  getCommentList(width) {
    var length = comments.value.length;
    for (var i = 0; i <= length; i++) {
      commentsWidgetList.add(Pullet(text: comments.value[i], width: width));
    }
  }

  @override
  Widget build(BuildContext context) {
    final videoData = Provider.of<ExcerciseVideoData>(context, listen: false);
    // final double height = MediaQuery.of(context).size.height*0.5;
    // final double width = MediaQuery.of(context).size.width;
    // double aspectRatio = _controller!.value.aspectRatio;
    final double height = ((MediaQuery.of(context).size.width) / (aspectRatio) -
            AppBar().preferredSize.height) *
        0.8;
    final double width = (MediaQuery.of(context).size.width);
    print('aho: $height .. $width');
    return Scaffold(
      appBar: AppBar(title: Text('YOUR RESULTS')),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: videoData.getData(width, height, context),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              _playVideo(File(videoPath.value));
              // if (comments.value.isNotEmpty) print('commenttt: ${comments.value[0]}');
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    // alignment: Alignment.center,
                    height: height,
                    width: width,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          // height: height,
                          // width: width,
                          child: AspectRatio(
                            aspectRatio: _controller!.value.aspectRatio,
                            child: VideoPlayer(_controller!),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          // height: height,
                          // width: width,
                          child: PainterWidget(
                            height: height,
                            width: width,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),
                  Column(
                    children: [
                      Pullet(text: 'NUMBER OF SQUATS IS ${squats.value[0]}', width: width),
                      if(comments.value.isEmpty)
                      Container()
                      else
                      Pullet(text: comments.value[0], width: width,),
                      // Pullet(text: comments.value[1], width: width,),
                      // Pullet(text: comments.value[3], width: width,),
                      // Pullet(text: comments.value[4], width: width,),

                      // commentsWidgetList as List<Widget>
                    ]
                  ),
                ],
              );

              // });
            }),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () =>
              _onImageButtonPressed(ImageSource.gallery, 500, 500, context)),
    );
  }
}

// class MySpecificPage extends StatefulWidget {
//     @override
//     State<StatefulWidget> createState() {
//         return _MySpecificPageState();
//     }
// }

// class _MySpecificPageState extends State<MySpecificPage> {

//     VideoPlayerController? controller;
//     VoidCallback? listener;

//     @override
//     void initState() {
//         listener = () => setState(() {});
//         videoHandler();
//         super.initState();
//     }
//   Future<void> _onImageButtonPressed(ImageSource source, double height,
//       double width, BuildContext context) async {
//     XFile? _file;
//     final ImagePicker _picker = ImagePicker();

//     _file = await _picker.pickVideo(
//         source: source, maxDuration: const Duration(seconds: 10));
//     videoPath.value = _file!.path;
//     // setState(() {});

//     // await _playVideo(_file);
//   }
//     void videoHandler() {
//         if (controller == null) {
//             controller = VideoPlayerController.file(File(videoPath.value))
//                 ..addListener(()=>listener!())
//                 ..setVolume(0.5)
//                 ..initialize();
//         } else {
//             if (controller!.value.isPlaying) {
//                 controller!.pause();
//             } else {
//                 controller!.play();
//             }
//         }
//     }


//     @override
//     Widget build(BuildContext context) {
//         return Scaffold(
//             appBar: AppBar(
//                 title: Text('Videop Provider Example'),
//             ),
//             body:Container(
//             child: Column(
//                 children: <Widget>[
//                     VideoProvider(controller!),
//                     RaisedButton(
//                         child: Text('click here to play & puase the video'),
//                         onPressed: () {
//                             videoHandler();
//                         },
//                         )
//                 ],
//                 ),
//             ),
//             floatingActionButton: FloatingActionButton(
//           onPressed: () =>
//               _onImageButtonPressed(ImageSource.gallery, 500, 500, context)),
//     );
        
//     }
// }

// class VideoProvider extends StatelessWidget {
//     final VideoPlayerController controller;

//     VideoProvider(this.controller);

//     @override
//     Widget build(BuildContext context) {
        // return AspectRatio(
//             aspectRatio: 16 / 9,
//             child: VideoPlayer(
//                 controller
//             ),
//         );
//     }
// }

