import 'package:flutter/material.dart';
import 'package:juma/widgets/backgroundVideo.dart';

List<Page> getPages() {
  return [
    Page(title: 'Onboarding page 1', desc: "You'll get swole AF", videoPath: "assets/video/antonioDeadlift.mp4",),
    Page(title: 'Onboarding page 2', desc: "And you'll get strong AF", videoPath: "assets/video/Lauren.mp4",),
    Page(title: 'Onboarding page 3', desc: "but you gotta put in the work", videoPath: "assets/video/paul.mp4",)
  ];
}

class Page extends StatelessWidget {
  final String title, desc, videoPath;
  
  Page({this.title, this.desc, this.videoPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          //BackgroundVideo(videoPath: videoPath,),
          PageUI(title: title, desc: desc),
        ],
      ),
    );
  }
}

class PageUI extends StatelessWidget {
  final String title, desc;
  PageUI({this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 6,
              child: Container(),
            ),
            Expanded(
              flex: 2,
              child: Text(title, style: TextStyle(color: Colors.white),),
            ),
            Expanded(
              flex: 3,
              child: Text(desc),
            ),
          ],
        ),
      ),
    );
  }
}