import 'package:flutter/material.dart';

class CustomRectTween extends RectTween {
  final Rect a, b;
  double Function(double t) curveTransform;
  CustomRectTween({this.a, this.b, this.curveTransform}) : super(begin: a, end: b);

  @override
  Rect lerp(double t) {
    final value = curveTransform == null ? t : curveTransform(t); // default linear

    return Rect.fromLTRB(
      lerpDouble(a.left, b.left, value),
      lerpDouble(a.top, b.top, value),
      lerpDouble(a.right, b.right, value),
      lerpDouble(a.bottom, b.bottom, value),
    );
  }

  double lerpDouble(num a, num b, double t) {
    if (a == null && b == null) return null;
    a ??= 0.0;
    b ??= 0.0;
    return a + (b - a) * t;
  }
}