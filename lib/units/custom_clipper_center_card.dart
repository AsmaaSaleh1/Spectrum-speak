import 'package:flutter/material.dart';
class CustomClipperCard extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double cornerRadius = 15.0;
    path.lineTo((size.width/1.4) - cornerRadius,0 );
    path.lineTo((size.width/4.5), size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
