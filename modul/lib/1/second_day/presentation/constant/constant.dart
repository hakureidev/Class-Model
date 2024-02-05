import 'package:flutter/material.dart';

class Constant {
  // color
  static const Color primary = Color.fromARGB(188, 158, 158, 158);
  static const Color body = Colors.white;

  // shimmer

  static const Color highlight = Color(0xFF808080);
  static const Color baseColor = Color(0xFFD3D3D3);

  // width
  static double width(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }

  // height
  static double height(BuildContext context) {
    return MediaQuery.sizeOf(context).height;
  }
}
