import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';
import 'package:juma/pages/app/home.dart';
import 'package:juma/theme/Colors.dart';
import 'package:juma/widgets/animatedStrokeLogo.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with SingleTickerProviderStateMixin{

  AnimationController animController;
  Animation<double> buttonAnim;
  Animation<double> titleAnim;
  double logoWidth = 200;

  @override
  void initState() {
    super.initState();
    animController = AnimationController(
      duration: Duration(seconds: 4),
      vsync: this
    );

    buttonAnim = CurvedAnimation(
      curve: Interval(
        0.8, 0.95,
        curve: Curves.bounceOut
      ), 
      parent: animController
    )
    ..addListener(() {
      setState(() {});
    });

    titleAnim = CurvedAnimation(
      curve: Interval(
        0.75, 0.9,
        curve: Curves.bounceOut
      ),
      parent: animController
    )
    ..addListener(() {
      setState(() {});
    });

    animController.forward();
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    double centerx = MediaQuery.of(context).size.width / 2 - (logoWidth / 2);
    double centery = MediaQuery.of(context).size.height / 2 - (logoWidth / 2);

    //what if this widget is onboarding but hidden and fades into it with logo still in tact
    // if not logged in then show welcome page
    if (user == null) {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: JumaColors.lightGreyGradient
          ),
          child: Stack(
            children: <Widget>[
              AnimatedStrokeLogo(xpos: centerx, ypos: centery, width: logoWidth,),
              Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 120,),
                    Text(
                      "WELCOME TO",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: titleAnim.value * 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "JUMA",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: titleAnim.value * 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Strength Training Redesigned",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                    SizedBox(height: 300,),
                    SizedBox(
                      width: buttonAnim.value * 250,
                      height: buttonAnim.value * 50,
                      child: RaisedButton(
                        child: Text("Join the GANG!", style: TextStyle(fontWeight: FontWeight.bold),),
                        onPressed: () {
                          setState(() {
                            logoWidth -= 100;
                          });
                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        elevation: 10,
                      ),
                    ),
                    SizedBox(height: 20,),
                    GestureDetector(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "I ALREADY HAVE",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w300
                            ),
                          ),
                          Text(
                            "AN ACCOUNT",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w200
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }
    // else return app *this return is done so that it will return here on logoff*
    else 
    {
      return Home();
    }
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

}