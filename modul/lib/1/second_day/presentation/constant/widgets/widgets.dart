import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  final double width, height;
  final EdgeInsets? padding, margin;
  final BoxDecoration decoration;
  final Widget child;
  const MyContainer(
      {super.key,
      required this.width,
      required this.height,
      required this.child,
      required this.decoration,
      this.margin,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: decoration,
      margin: margin,
      padding: padding,
      child: child,
    );
  }
}
