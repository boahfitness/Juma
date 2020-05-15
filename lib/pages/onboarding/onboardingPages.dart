import 'package:flutter/material.dart';

List<OnboardingPage> getPages() {
  return [
    OnboardingPage(
      title: 'Track Progress', 
      desc: "Track your strength progress easily and intuitively.", 
      videoPath: "assets/video/antonioDeadlift.mp4",
    ),
    OnboardingPage(
      title: 'Create & Share Programs', 
      desc: "Customize your own training experience.", 
      videoPath: "assets/video/Lauren.mp4",
    ),
    OnboardingPage(
      title: 'Stay Connected', 
      desc: "Once place for coaches and athletes to easily interact.", 
      videoPath: "assets/video/paul.mp4",
    )
  ];
}

class OnboardingPage extends StatelessWidget {
  final String title, desc, videoPath;
  
  OnboardingPage({this.title, this.desc, this.videoPath});
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
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: screenHeight * 0.2,),
            SizedBox(
              height: screenHeight * 0.5,
              width: screenWidth,
              child: Center(
                child: Stack(
                  children: <Widget>[
                    Transform.scale(
                      scale: 0.9,
                      origin: Offset(-350.0, 0.0),
                      alignment: Alignment.topLeft,
                      child: AspectRatio(
                        aspectRatio: 9 / 16,
                        child: Image.asset('assets/onboardingScreens/trackProgress2.png'),
                      ),
                    ),
                    Transform.scale(
                      scale: 0.9,
                      origin: Offset(350.0, 0.0),
                      alignment: Alignment.bottomRight,
                      child: AspectRatio(
                        aspectRatio: 9 / 16,
                        child: Image.asset('assets/onboardingScreens/trackProgress1.png'),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 55.0),
              child: Text(title, 
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w800),),
            ),
            SizedBox(height: screenHeight * 0.03,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 65.0),
              child: Text(desc, 
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w200),
              ),
            ),
          ],
        ),
      ),
    );
  }
}