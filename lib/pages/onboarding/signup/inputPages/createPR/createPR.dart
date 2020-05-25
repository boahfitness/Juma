import 'package:flutter/material.dart';
import 'package:juma/models/lifting/exercise.dart';
import 'package:juma/models/lifting/personalRecords.dart';
import 'package:juma/models/lifting/weight.dart';
import 'package:juma/pages/onboarding/signup/inputPages/createPR/customizeLift.dart';
import 'package:juma/theme/Colors.dart';
import 'package:juma/pages/onboarding/signup/inputPages/createPR/chooseLift.dart';

class CreatePR extends StatefulWidget {
  final WeightUnit unitPreference;
  CreatePR({this.unitPreference=WeightUnit.pounds});
  @override
  _CreatePRState createState() => _CreatePRState();
}

class _CreatePRState extends State<CreatePR> {
  String title;
  PersonalRecord pr = PersonalRecord(
    '0', 0, 0, Squat()
  );
  PageController controller = PageController();

  @override
  void initState() {
    title = titles[0];
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override 
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: JumaColors.lightGreyGradient
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(title, style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() {
              title = titles[index];
            });
          },
          children: <Widget>[
            ChooseLift(pr),
            CustomizeLift(pr),
          ],
        ),
        floatingActionButton: FlatButton(
          onPressed: () {
            setState(() {
              controller.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
            });
          },
          child: Text('NEXT', style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}

List<String> titles = [
  'Choose a Lift', '', 'Weight'
];

