import 'package:flutter/material.dart';

class CustomClipperShadowTeacher extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double widthSize = size.width;
    double heightSize = size.height;

    double radius = widthSize / 6; // Change to width for top and bottom circles
    double radius2 = heightSize / 6; // Change to height for left and right circles

    // Draw the square
    path.moveTo(0, radius);
    path.arcToPoint(
      Offset(radius, 0),
      radius: Radius.circular(radius),
      largeArc: false,
      clockwise: false,
    );

    path.lineTo(widthSize - radius, 0);
    path.arcToPoint(
      Offset(widthSize, radius),
      radius: Radius.circular(radius),
      largeArc: false,
      clockwise: false,
    );

    path.lineTo(widthSize, heightSize - radius2);
    path.arcToPoint(
      Offset(widthSize - radius2, heightSize),
      radius: Radius.circular(radius2),
      largeArc: false,
      clockwise: false,
    );

    path.lineTo(radius2, heightSize);
    path.arcToPoint(
      Offset(0, heightSize - radius2),
      radius: Radius.circular(radius2),
      largeArc: false,
      clockwise: false,
    );

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
