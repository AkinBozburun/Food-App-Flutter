import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles
{
  static Color whiteColor = const Color(0xffF3F3F3);
  static Color greyColor = const Color(0xFFE3E3E3);
  static Color blackColor = const Color(0xff0E0E0E);
  static Color greenColor = const Color(0xff2FA62F);

  final whiteTitle = GoogleFonts.poppins(fontSize: 20, color: whiteColor,fontWeight: FontWeight.bold);
  final blackTitle = GoogleFonts.poppins(fontSize: 20, color: blackColor,fontWeight: FontWeight.bold);

  final blackSubTitle = GoogleFonts.poppins(fontSize: 16, color: blackColor,fontWeight: FontWeight.w600);
}