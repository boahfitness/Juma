// for user to select gender and bodyweight
import 'package:flutter/material.dart';
import 'package:juma/models/users/user.dart';
import 'package:juma/theme/Colors.dart';
import 'package:juma/theme/jumaIcons.dart';
import 'package:juma/widgets/weightPicker.dart';

class InputHealthData extends StatefulWidget {
  final User user;
  final String Function(String) genderValidator;
  InputHealthData(this.user, {this.genderValidator});
  @override
  _InputHealthDataState createState() => _InputHealthDataState();
}

class _InputHealthDataState extends State<InputHealthData> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          '${widget.user.displayName}, help us manage your strength stats with the following data.'
        ),

        SizedBox(height: MediaQuery.of(context).size.height*0.05,),

        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Text('Bodyweight', style: TextStyle(fontSize: 15.0),),
        ),
        WeightPicker(
          widget.user.bodyweight, unit: widget.user.unitPreference,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text('*you can adjust this later*', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),),
        ),

        SizedBox(height: MediaQuery.of(context).size.height*0.1,),

        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Text('Gender', style: TextStyle(fontSize: 15.0),),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            GenderPicker(
              gender: Gender.male, enabled: widget.user.gender == Gender.male,
              onTap: () {
                setState(() {
                  widget.user.gender = Gender.male;
                });
              },
            ),
            GenderPicker(
              gender: Gender.female, enabled: widget.user.gender == Gender.female,
              onTap: () {
                setState(() {
                  widget.user.gender = Gender.female;
                });
              },
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: FlatButton(
            onPressed: () {
              setState(() {
                widget.user.gender = Gender.unspecified;
              });
            },
            child: Text('I prefer not to answer.', style: TextStyle(fontSize: 15.0),),
            textColor: widget.user.gender == Gender.unspecified ? JumaColors.boahOrange : Colors.grey[700],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(
                color: widget.user.gender == Gender.unspecified ? JumaColors.boahOrange : Colors.grey[700],
                width: 2.0
              ),
            ),
          ),
        ),
        FormField(
          builder: (state) {
            return Text(state.hasError? state.errorText : '', style: TextStyle(color: Colors.red, fontSize: 12.0),);
          },
          validator: widget.genderValidator,
        ),
      ],
    );
  }
}

class GenderPicker extends StatefulWidget {
  final Gender gender;
  final void Function() onTap;
  final bool enabled;
  GenderPicker({this.gender=Gender.male, this.onTap, this.enabled=true});
  @override
  _GenderPickerState createState() => _GenderPickerState();
}

class _GenderPickerState extends State<GenderPicker> {
  IconData genderIcon;
  double iconSize = 130;

  @override
  void initState() {
    if (widget.gender == Gender.male) genderIcon = JumaIcons.male;
    else if (widget.gender == Gender.female) genderIcon = JumaIcons.female;
    else genderIcon = Icons.error;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: widget.enabled ? BlendMode.srcIn : BlendMode.dst,
      shaderCallback: (bounds) {
        return LinearGradient(
          colors: [JumaColors.darkRed, JumaColors.boahOrange, Colors.white],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ).createShader(bounds);
      },
      child: FlatButton.icon(
        onPressed: widget.onTap,
        icon: Icon(genderIcon),
        label: Text(
          widget.gender == Gender.male ? 'MALE' : 'FEMALE',
          style: TextStyle(
            color: Colors.grey[700],
            fontWeight: FontWeight.bold,
            fontSize: 15
          ),
        ),
      ),
    );
  }
}