import 'package:flutter/material.dart';
import 'package:juma/models/lifting/exercise.dart';
import 'package:juma/models/lifting/personalRecords.dart';
import 'package:juma/models/lifting/weight.dart';
import 'package:juma/pages/onboarding/signup/inputPages/createPR/customizeLift.dart';
import 'package:juma/theme/Colors.dart';
import 'package:juma/pages/onboarding/signup/inputPages/createPR/chooseLift.dart';
import 'package:juma/pages/onboarding/signup/inputPages/createPR/enterWeight.dart';

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
  int currentIndex = 0;
  var formKey = GlobalKey<FormState>();

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
      'Enter a Weight': EnterWeight(pr, unitPreference: widget.unitPreference,),
    };

    title ??= pages.keys.toList()[0];

    return Form(
      key: formKey,
      child: Container(
        decoration: BoxDecoration(
          gradient: JumaColors.lightGreyGradient
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.clear, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ), 
            title: Text(title, style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          body: PageView.builder(
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
                title = pages.keys.toList()[index];
              });
            },
            itemCount: pages.length,
            itemBuilder: (context, index) {
              return pages.values.toList()[index];
            },
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    setState(() {
                      if (currentIndex != 0)
                        controller.previousPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                      else {
                        Navigator.of(context).pop();
                      }
                    });
                  },
                  child: Text('BACK', style: TextStyle(color: Colors.white),),
                ),
                FlatButton(
                  onPressed: () {
                    setState(() {
                      if (currentIndex != pages.length - 1)
                        controller.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                      else {
                        if (formKey.currentState.validate()) Navigator.of(context).pop<PersonalRecord>(pr);
                      }
                    });
                  },
                  child: Text(currentIndex != pages.length - 1 ? 'NEXT' : 'FINISH', style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

