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
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override 
  Widget build(BuildContext context) {

    Map<String, Widget> pages = {
      'Choose a Lift': ChooseLift(pr),
      'Customize the Lift': CustomizeLift(pr),
      'Test': Center(child: Text(pr.lift.descriptor.path),)
    };

    title ??= pages.keys.toList()[0];

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
        body: PageView.builder(
          controller: controller,
          onPageChanged: (index) {
            setState(() {
              title = pages.keys.toList()[index];
            });
          },
          itemBuilder: (context, index) {
            return pages.values.toList()[index];
          },
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

