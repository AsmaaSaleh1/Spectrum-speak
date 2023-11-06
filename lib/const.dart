import 'package:flutter/material.dart';

const Color kBlue= Color(0xff04b5e4);
const Color kPrimary= Color(0xffE8E5E0);
const Color kRed= Color(0xffE61B23);
const Color kDarkBlue= Color(0xff0E5F88);
const Color kYellow=Color(0xffF6EE04);
Color kDarkerColor = Color.fromARGB(
  kDarkBlue.alpha,  // Keep the alpha channel the same
  kDarkBlue.red ~/ 2, // Reduce the red component by half
  kDarkBlue.green ~/ 2, // Reduce the green component by half
  kDarkBlue.blue ~/ 2, // Reduce the blue component by half
);
