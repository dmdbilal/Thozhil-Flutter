import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle dmSansStyle(double size, {FontWeight fontWeight = FontWeight.normal, Color color = Colors.black}) {
  return GoogleFonts.dmSans(
    fontSize: size,
    fontWeight: fontWeight,
    color: color,
  );
}