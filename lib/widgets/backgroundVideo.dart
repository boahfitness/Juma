import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BackgroundVideo extends StatefulWidget {

  final String videoPath;

  BackgroundVideo({this.videoPath});

  @override
  _BackgroundVideoState createState() => _BackgroundVideoState(videoPath: this.videoPath);
}

class _BackgroundVideoState extends State<BackgroundVideo> {

  final String videoPath;
  VideoPlayerController _controller;

  _BackgroundVideoState({this.videoPath});

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(videoPath)..initialize().then((_) {
      _controller.setLooping(true);
      _controller.setVolume(0.0);
      _controller.play();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.fill,
        child: SizedBox(
          width: _controller.value.size?.width ?? 0,
          height: _controller.value.size?.height ?? 0,
          child: VideoPlayer(_controller),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}