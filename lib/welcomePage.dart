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

class _WelcomePageState extends State<WelcomePage> {

  double logoWidth = 200;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    double centerx = MediaQuery.of(context).size.width / 2 - (logoWidth / 2);
    double centery = MediaQuery.of(context).size.height / 2 - (logoWidth / 2);

    //what if this widget is onboarding but hidden and fades into it with logo still in tact
    // if not logged in then show welcome page
    if (user == null) {
      return Container(
        decoration: BoxDecoration(
          gradient: JumaColors.lightGreyGradient
        ),
        child: Stack(
          children: <Widget>[
            AnimatedStrokeLogo(xpos: centerx, ypos: centery, width: logoWidth,),
            Column(
              children: <Widget>[
                Expanded(flex: 12,
                  child: Container(),
                ),
                Expanded(flex: 3,
                  child: FlatButton(
                    child: Text("JOIN THE GANG!"),
                    onPressed: () {
                      setState(() {
                        logoWidth -= 100;
                      });
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }
    // else return app *this return is so that it will return here on logoff*
    else 
    {
      return Home();
    }
  }

}