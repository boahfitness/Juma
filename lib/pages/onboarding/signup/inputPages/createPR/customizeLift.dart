import 'package:flutter/material.dart';
import 'package:juma/models/lifting/exercise.dart';
import 'package:juma/models/lifting/personalRecords.dart';
import './squatCustomizer.dart';
import './benchCustomizer.dart';
import './deadCustomizer.dart';

class CustomizeLift extends StatefulWidget {
  final PersonalRecord personalRecord;
  CustomizeLift(this.personalRecord);
  @override
  _CustomizeLiftState createState() => _CustomizeLiftState();
}

class _CustomizeLiftState extends State<CustomizeLift> {
  @override
  Widget build(BuildContext context) {
    switch (widget.personalRecord.lift.type) {
      case MainLiftType.squat: return SquatCustomizer(widget.personalRecord);
      case MainLiftType.deadlift: return DeadCustomizer(widget.personalRecord);
      case MainLiftType.bench: return BenchCustomizer(widget.personalRecord);
      default: throw Exception('invalid MainLiftType in personalRecord');
    }
  }
}

// class Picker extends StatefulWidget {
//   final String text;
//   final bool enabled;
//   final Function() onTap;
//   Picker(this.text, {this.enabled=false, @required this.onTap});
//   @override
//   _PickerState createState() => _PickerState();
// }

// class _PickerState extends State<Picker> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: widget.onTap,
//       child: AnimatedContainer(
//         duration: Duration(milliseconds: 200),
//         curve: Curves.easeInOut,
//         height: 100,
//         width: 100,
//         color: widget.enabled ? Colors.black : Colors.black45,
//         child: Center(
//           child: Text(widget.text, style: TextStyle(color: widget.enabled ? Colors.white : Colors.grey[700],),),
//         ),
//       ),
//     );
//   }
// }