import 'package:flutter/material.dart';
import 'package:juma/models/lifting/personalRecords.dart';

class CustomizeLift extends StatefulWidget {
  final PersonalRecord personalRecord;
  CustomizeLift(this.personalRecord);
  @override
  _CustomizeLiftState createState() => _CustomizeLiftState();
}

class _CustomizeLiftState extends State<CustomizeLift> {
  @override
  Widget build(BuildContext context) {
    switch (widget.personalRecord.lift.name) {
      case 'Squat': return SquatCustomizer();
      case 'Deadlift': return DeadCustomizer();
      case 'Bench': return BenchCustomizer();
      default: return SquatCustomizer();
    }
  }
}

class SquatCustomizer extends StatefulWidget {
  @override
  _SquatCustomizerState createState() => _SquatCustomizerState();
}

class _SquatCustomizerState extends State<SquatCustomizer> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Squat'),
    );
  }
}

class BenchCustomizer extends StatefulWidget {
  @override
  _BenchCustomizerState createState() => _BenchCustomizerState();
}

class _BenchCustomizerState extends State<BenchCustomizer> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Bench'),
    );
  }
}

class DeadCustomizer extends StatefulWidget {
  @override
  _DeadCustomizerState createState() => _DeadCustomizerState();
}

class _DeadCustomizerState extends State<DeadCustomizer> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Deadlift'),
    );
  }
}