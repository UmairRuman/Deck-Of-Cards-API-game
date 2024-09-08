import 'package:flutter/material.dart';

class MyShaderMask {
  static var shaderMaskCallBack = (bounds) {
    return const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        stops: [0.3, 0.5, 1],
        tileMode: TileMode.mirror,
        colors: [
          Colors.red,
          Colors.pink,
          Colors.purple,
        ]).createShader(bounds);
  };
}
