// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:my_pt/providers/exercise_video_data.dart';
// import 'package:my_pt/value_notifiers/value_notifiers.dart';
// import 'package:my_pt/widgets/painter_widget.dart';
// import 'package:my_pt/widgets/step.dart';
// import 'package:provider/provider.dart';
// import 'dart:io';
// import 'package:video_player/video_player.dart';
// import 'package:flutter_video_info/flutter_video_info.dart';

// class VideoDisplay extends StatefulWidget {
//   const VideoDisplay({Key? key}) : super(key: key);

//   @override
//   State<VideoDisplay> createState() => _VideoDisplayState();
// }

// class _VideoDisplayState extends State<VideoDisplay> {
//   VideoPlayerController? _controller;
//   VideoPlayerController? _toBeDisposed;
//   // bool _isVideoDone = false;
//   bool _isPlaying = false;
//   Duration? _duration;
//   Duration? _position;
//   bool _isEnd = false;
//   double videoDurtion = 0;
//   double aspectRatio = 16 / 9;
//   // int height = 0;
//   // int width = 0;

//   @override
//   void deactivate() {
//     if (_controller != null) {
//       _controller!.setVolume(0.0);
//       _controller!.pause();
//     }
//     super.deactivate();
//   }

//   @override
//   void dispose() {
//     _disposeVideoController();
//     super.dispose();
//   }

//   Future<void> _disposeVideoController() async {
//     if (_toBeDisposed != null) {
//       await _toBeDisposed!.dispose();
//     }
//     _toBeDisposed = _controller;
//     _controller = null;
//   }

//   Future<dynamic> _initVideoPlayer() async {
//     try {
//       _controller = VideoPlayerController.file(File(videoPath.value));
//       var _initializedControllerFuture = await _controller!.initialize();
//       _controller!.setLooping(false);
//       setState(() {
//         aspectRatio = _controller!.value.aspectRatio;
//         //     _duration = _controller!.value.duration;
//       });
//       // ..addListener(() {
//       // final bool isPlaying = _controller!.value.isPlaying;
//       // if (isPlaying != _isPlaying) {
//       //   setState(() {
//       //     _isPlaying = isPlaying;
//       //   });
//       // }
//       // Timer.run(() {
//       //     this.setState((){
//       //       _position = _controller!.value.position;
//       //     });
//       //   });
//       //   setState(() {
//       //   });
//       //   _duration?.compareTo(_position as Duration) == 0 || _duration?.compareTo(_position as Duration) == -1 ? this.setState((){
//       //     _isEnd = true;
//       //   }) : this.setState((){
//       //     _isEnd = false;
//       //   });
//       // })
//       // ..initialize();
//       // !.initialize();
//       // _controller!.addListener(() {
//       // setState(() {
//       //   videoDurtion = _controller!.value.duration;
//       //   print('videoDurtion: $videoDurtion');
//       // });
//       // });
//       // _controller!.addListener(() {
//       //   if (_controller!.value.position == _controller!.value.duration) {
//       //     setState(() {
//       //       print('video ended');
//       //       _isVideoDone = true;
//       //     });
//       // }
//       // });
//       return _initializedControllerFuture;
//     } catch (error) {
//       print('error: $error');
//     }
//   }

//   void videoInfo() async {
//     try {
//       final videoInfo = FlutterVideoInfo();

//       String videoFilePath = videoPath.value;
//       var info = await videoInfo.getVideoInfo(videoFilePath);
//       print('info: ${info}');
//       print('duration: ${info!.duration}');
//       // print('framerate: ${info.framerate}');
//       // print('width: ${info.width}');
//       // print('height: ${info.height}');
//       setState(() {
//         videoDurtion = info.duration as double;
//         // height = info.height as int;
//         // width = info.width as int;
//       });
//     } catch (error) {
//       print('error: $error');
//     }
//   }

//   // void _checkVideo() {
//   //   bool state = true;
//   //   _controller!.addListener(() {
//   //     // Implement your calls inside these conditions' bodies :
//   //     // if (_controller!.value.position ==
//   //     //     Duration(seconds: 0, minutes: 0, hours: 0)) {
//   //     //   print('video Started');
//   //     // }

//   //     if (_controller!.value.position == _controller!.value.duration) {
//   //       print('video ended');
//   //       setState(() {
//   //         _isVideoDone = true;
//   //         state = false;
//   //       });
//   //     }
//   //   });
//   //   // _controller!.notifyListeners();
//   // }

//   void _playVideo(File? file) {
//     _controller!.play();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // videoInfo();

//     final videoData = Provider.of<ExcerciseVideoData>(context, listen: false);
//     final double height = ((MediaQuery.of(context).size.width) / (aspectRatio) -
//             AppBar().preferredSize.height) *
//         1;
//     final double width = (MediaQuery.of(context).size.width);
//     print('width: $width');
//     print('height: $height');

//     return
//         // !_isEnd
//         // ?
//         SingleChildScrollView(
//             child: FutureBuilder(
//                 future: _initVideoPlayer(),
//                 builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
//                   if (snapshot.connectionState == ConnectionState.done) {
//                     return FutureBuilder(
//                         future: videoData.getData(
//                             width, height, context, videoDurtion),
//                         builder: (BuildContext context,
//                             AsyncSnapshot<void> snapshot) {
//                           _playVideo(File(videoPath.value));
//                           return Column(
//                             children: [
//                               Container(
//                                 // alignment: Alignment.center,
//                                 height: height,
//                                 width: width,
//                                 child: Stack(
//                                   children: <Widget>[
//                                     Container(
//                                       alignment: Alignment.center,
//                                       // height: height,
//                                       // width: width,
//                                       child: AspectRatio(
//                                         aspectRatio:
//                                             _controller!.value.aspectRatio,
//                                         child: VideoPlayer(_controller!),
//                                       ),
//                                     ),
//                                     Container(
//                                       alignment: Alignment.center,
//                                       // height: height,
//                                       // width: width,
//                                       child: PainterWidget(
//                                         height: height,
//                                         width: width,
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                               Column(
//                                 children: <Widget>[
//                                   if (comments.value.isNotEmpty)
//                                     Pullet(
//                                         text: comments.value[0], width: width)
//                                   // comments.value
//                                   //     .map((comment) => {
//                                   //           Pullet(text: comment, width: width),
//                                   //         })
//                                   //     .toList() as List<Widget>
//                                 ],
//                               ),
//                             ],
//                           );
//                         });
//                   } else {
//                     return const Center(
//                         child: CircularProgressIndicator(
//                       color: Color.fromRGBO(143, 148, 251, 1),
//                     ));
//                   }
//                 }));
//   }
// }
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_pt/providers/exercise_video_data.dart';
import 'package:my_pt/value_notifiers/value_notifiers.dart';
import 'package:my_pt/widgets/painter_widget.dart';
import 'package:my_pt/widgets/pullet.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:video_player/video_player.dart';

class VideoDisplay extends StatefulWidget {
  const VideoDisplay({Key? key}) : super(key: key);

  @override
  State<VideoDisplay> createState() => _VideoDisplayState();
}

class _VideoDisplayState extends State<VideoDisplay> {
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

  Future<dynamic> _initVideoPlayer() async {
    try {
      _controller = VideoPlayerController.file(File(videoPath.value));
      var _initializedControllerFuture = _controller!.initialize();
      // ..addListener(() {
      // final bool isPlaying = _controller!.value.isPlaying;
      // if (isPlaying != _isPlaying) {
      //   setState(() {
      //     _isPlaying = isPlaying;
      //   });
      // }
      // Timer.run(() {
      //     this.setState((){
      //       _position = _controller!.value.position;
      //     });
      //   });
      //   setState(() {
      //     _duration = _controller!.value.duration;
      //   });
      //   _duration?.compareTo(_position as Duration) == 0 || _duration?.compareTo(_position as Duration) == -1 ? this.setState((){
      //     _isEnd = true;
      //   }) : this.setState((){
      //     _isEnd = false;
      //   });
      // })
      // ..initialize();
      // !.initialize();
      _controller!.setLooping(false);
      // _controller!.addListener(() {
      //   if (_controller!.value.position == _controller!.value.duration) {
      //     setState(() {
      //       print('video ended');
      //       _isVideoDone = true;
      //     });
      // }
      // });
      return _initializedControllerFuture;
    } catch (error) {
      print('error: $error');
    }
  }

  // void _checkVideo() {
  //   bool state = true;
  //   _controller!.addListener(() {
  //     // Implement your calls inside these conditions' bodies :
  //     // if (_controller!.value.position ==
  //     //     Duration(seconds: 0, minutes: 0, hours: 0)) {
  //     //   print('video Started');
  //     // }

  //     if (_controller!.value.position == _controller!.value.duration) {
  //       print('video ended');
  //       setState(() {
  //         _isVideoDone = true;
  //         state = false;
  //       });
  //     }
  //   });
  //   // _controller!.notifyListeners();
  // }

  void _playVideo(File? file) {
    _controller!.play();
  }

  @override
  Widget build(BuildContext context) {
    final videoData = Provider.of<ExcerciseVideoData>(context, listen: false);
    // final double height = MediaQuery.of(context).size.height;
    // final double width = MediaQuery.of(context).size.width;
    final double height = ((MediaQuery.of(context).size.width) / (aspectRatio) -
            AppBar().preferredSize.height) *
        0.7;
    final double width = (MediaQuery.of(context).size.width);
    return
        // !_isEnd
        // ?

        FutureBuilder(
            future: videoData.getData(width, height, context),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              return FutureBuilder(
                  future: _initVideoPlayer(),
                  builder:
                      (BuildContext context, AsyncSnapshot<void> snapshot) {
                    // if (snapshot.connectionState == ConnectionState.waiting) {}
                    if (snapshot.connectionState == ConnectionState.done) {
                      // _playVideo(File(videoPath.value));
                      // _checkVideo();
                      return
                          // !_isVideoDone
                          // ?
                          Container(
                        height: height,
                        width: width,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              child: AspectRatio(
                                aspectRatio: _controller!.value.aspectRatio,
                                child: VideoPlayer(_controller!),
                              ),
                            ),
                            PainterWidget(
                              height: height,
                              width: width,
                            ),
                            Column(
                              children: <Widget>[
                                if (comments.value.isNotEmpty)
                                  Pullet(text: comments.value[0], width: width)
                              ],
                            ),
                          ],
                        ),
                      );
                      // : Container(child: Text('here'));
                    } else {
                      return Center(
                          child: CircularProgressIndicator(
                        color: Color.fromRGBO(143, 148, 251, 1),
                      ));
                    }
                  });
            });
    // : Container(child: Text('heree'));
  }
}
