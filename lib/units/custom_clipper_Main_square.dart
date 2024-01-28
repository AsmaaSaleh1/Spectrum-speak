import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class MyCustomClipperMainSquare extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double widthSize = size.width;
    double heightSize = size.height - (size.height / 4);
    double radius2 = kIsWeb ? heightSize / 4 : widthSize / 4;

    //Draw the square
    path.moveTo(0, 0);
    path.lineTo(widthSize, 0);
    path.lineTo(widthSize, heightSize);
    path.lineTo(0, heightSize);
    path.close();

    path.moveTo(widthSize / 2 - radius2, heightSize);
    path.arcTo(
      Rect.fromCircle(
        center: Offset(widthSize / 2, heightSize),
        radius: radius2,
      ),
      pi, // Start angle (180 degrees)
      -pi, // Sweep angle (180 degrees for a half-circle)
      false,
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
