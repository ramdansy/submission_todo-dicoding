import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText {
  static final textTheme = TextTheme(bodyLarge: fBodyLarge);

  //heading
  static final TextStyle fHeading0 =
      GoogleFonts.inter(fontSize: 55, color: Colors.black);
  static final TextStyle fHeading1 =
      GoogleFonts.inter(fontSize: 34, color: Colors.black);
  static final TextStyle fHeading2 =
      GoogleFonts.inter(fontSize: 28, color: Colors.black);
  static final TextStyle fHeading3 =
      GoogleFonts.inter(fontSize: 24, color: Colors.black);
  static final TextStyle fHeading4 =
      GoogleFonts.inter(fontSize: 22, color: Colors.black);
  static final TextStyle fHeading5 =
      GoogleFonts.inter(fontSize: 20, color: Colors.black);
  static final TextStyle fHeading6 =
      GoogleFonts.inter(fontSize: 18, color: Colors.black);

  //body
  static final TextStyle fBodyLarge =
      GoogleFonts.inter(fontSize: 16, color: Colors.black);
  static final TextStyle fBodySmall =
      GoogleFonts.inter(fontSize: 14, color: Colors.black);

  //caption
  static final TextStyle fCaptionLarge =
      GoogleFonts.inter(fontSize: 12, color: Colors.black);
  static final TextStyle fCaptionSmall =
      GoogleFonts.inter(fontSize: 10, color: Colors.black);
}
