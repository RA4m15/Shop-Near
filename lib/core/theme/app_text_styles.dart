import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle get nunito => GoogleFonts.nunito();
  static TextStyle get poppins => GoogleFonts.poppins();

  static TextStyle get h1 => poppins.copyWith(fontWeight: FontWeight.w900, fontSize: 26);
  static TextStyle get h2 => poppins.copyWith(fontWeight: FontWeight.w800, fontSize: 22);
  static TextStyle get h3 => poppins.copyWith(fontWeight: FontWeight.w800, fontSize: 18);
  static TextStyle get h4 => poppins.copyWith(fontWeight: FontWeight.w700, fontSize: 16);

  static TextStyle get bodyLarge => nunito.copyWith(fontWeight: FontWeight.w400, fontSize: 16);
  static TextStyle get bodyMedium => nunito.copyWith(fontWeight: FontWeight.w400, fontSize: 14);
  static TextStyle get bodySmall => nunito.copyWith(fontWeight: FontWeight.w400, fontSize: 12);

  static TextStyle get labelLarge => nunito.copyWith(fontWeight: FontWeight.w800, fontSize: 14);
  static TextStyle get labelMedium => nunito.copyWith(fontWeight: FontWeight.w700, fontSize: 12);
  static TextStyle get labelSmall => nunito.copyWith(fontWeight: FontWeight.w700, fontSize: 10);
}
