// for user to select gender and bodyweight
import 'package:flutter/material.dart';
import 'package:juma/models/users/user.dart';
import 'package:juma/theme/Colors.dart';
import 'package:juma/theme/jumaIcons.dart';
import 'package:juma/widgets/weightPicker.dart';

class InputHealthData extends StatefulWidget {
  final User user;
  InputHealthData(this.user);
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

        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Text('Bodyweight'),
        ),
        WeightPicker(
          widget.user.bodyweight, unit: widget.user.unitPreference,
        ),

        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Text('Gender'),
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
            child: Text('I prefer not to answer.',),
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
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 200,
            child: IconButton(
              onPressed: widget.onTap,
              icon: Icon(genderIcon, color: Colors.grey[700],),
              iconSize: genderIcon == JumaIcons.female ? iconSize * 1.2 : iconSize,
            ),
          ),
          Text(
            widget.gender == Gender.male ? 'MALE' : 'FEMALE',
            style: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.bold,
              fontSize: 15
            ),
          ),
        ],
      ),
    );
  }
}