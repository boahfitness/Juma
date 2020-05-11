import 'package:flutter/material.dart';
import 'package:juma/theme/Colors.dart';

class PageIndexIndicator extends StatelessWidget {
  final bool isCurrent;
  final double size;
  PageIndexIndicator(this.isCurrent, this.size);
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      padding: EdgeInsets.symmetric(horizontal: 2.0),
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: isCurrent ? JumaColors.boahOrange : Colors.grey[900],
        borderRadius: BorderRadius.circular(12)
      ),
      duration: Duration(milliseconds: 100),
      curve: Curves.linear,
    );
  }
}