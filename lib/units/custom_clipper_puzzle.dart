import 'dart:math';

import 'package:flutter/material.dart';

class CustomClipperTest extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double widthSize=size.width-(size.width/6);
    double heightSize=size.height-(size.height/6);
    double radius = heightSize / 6;
    double radius2 = widthSize / 6;

    //Draw the square
    path.moveTo(0, 0);
    path.lineTo(widthSize, 0);
    path.lineTo(widthSize, heightSize);
    path.lineTo(0, heightSize);
    path.close();

    path.moveTo(widthSize / 2 - radius2, heightSize);
    path.arcTo(
      Rect.fromCircle(center: Offset(widthSize / 2, heightSize), radius: radius2),
      pi, // Start angle (180 degrees)
      -pi, // Sweep angle (180 degrees for a half-circle)
      false,
    );
    // Crop from the right side
    path.moveTo(widthSize, heightSize / 3);
    path.arcToPoint(
      Offset(widthSize, 2 * heightSize / 3),
      radius: Radius.circular(radius),
      largeArc: false,
      clockwise: false,
    );

    // Crop from the left side
    path.moveTo(0, 2 * heightSize / 3);
    path.arcToPoint(
      Offset(0, heightSize / 3),
      radius: Radius.circular(radius),
      largeArc: false,
      clockwise: false, // Change the direction for the left crop
    );

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
// path.arcToPoint(
//   Offset(size.width/3, 0),
//   radius: Radius.circular(cornerRadius),
//   clockwise: false,
// );
