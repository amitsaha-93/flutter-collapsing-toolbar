import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonStyle {
  static TextStyle getAppFont(
      {Color color,
      double fontSize,
      FontWeight fontWeight,
      FontStyle fontStyle, TextDecoration decoration}) {
    return GoogleFonts.montserrat(
      textStyle: TextStyle(color: color, letterSpacing: 0.3, decoration: decoration != null ? decoration : TextDecoration.none),
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle == null ? FontStyle.normal : fontStyle
    );
  }
}
