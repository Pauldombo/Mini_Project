import 'package:flutter/material.dart';
import 'colors.dart';

const bold = ' Roboto-Bold';
const regular = ' Roboto-Regular';

ourstyle({family = regular, double? size = 14, Color = whitecolor}) {
  return TextStyle(
    fontSize: size,
    color: Color,
    fontFamily: family,
  );
}
