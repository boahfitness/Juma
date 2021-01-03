import 'package:flutter/material.dart';
import 'package:juma/models/lifting/program.dart';
import 'package:juma/theme/Colors.dart';

class ProgramDecal extends StatelessWidget {
  final ProgramDescriptor program;
  final double width;
  ProgramDecal(this.program, {this.width = 160});
  @override
  Widget build(BuildContext context) {
    ColorTheme theme = program != null ? program.theme ?? BlackTheme() : BlackTheme();
    return program != null ? Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: SizedBox(
        width: this.width,
        child: Container(
          decoration: BoxDecoration(
            gradient: theme.gradient,
            borderRadius: BorderRadius.circular(20)
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(program.title ?? '', style: TextStyle(fontWeight: FontWeight.bold, color: theme.textColor)),
                Text(program.author != null ? program.author.displayName ?? '' : '', style: TextStyle(color: theme.textColor),)
              ],
            ),
          ),
        ),
      ),
    ) : Container(width: 0, height: 0,);
  }
}