import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles
{
  static Color whiteColor = const Color(0xffF3F3F3);
  static Color greyColor = const Color(0xFFE3E3E3);
  static Color darkGreyColor = const Color(0xFFD9D9D9);
  static Color blackColor = const Color(0xff0E0E0E);
  static Color greenColor = const Color(0xff2FA62F);

  final titleWhite = GoogleFonts.poppins(fontSize: 20, color: whiteColor,fontWeight: FontWeight.bold);
  final titleBlack = GoogleFonts.poppins(fontSize: 20, color: blackColor,fontWeight: FontWeight.bold);
  final subTitleBlack = GoogleFonts.poppins(fontSize: 16, color: blackColor,fontWeight: FontWeight.w600);

  final searchBarHintText = GoogleFonts.poppins(fontSize: 16, color: darkGreyColor, fontWeight: FontWeight.w400);

  final categorieText = GoogleFonts.poppins(fontSize: 12, color: blackColor, fontWeight: FontWeight.w400);

  final recentlyText1 = GoogleFonts.poppins(fontSize: 12, color: blackColor, fontWeight: FontWeight.w500);
  final recentlyText2 = GoogleFonts.poppins(fontSize: 10, color: blackColor, fontWeight: FontWeight.w300);
  final recentlyText3 = GoogleFonts.poppins(fontSize: 12, color: blackColor, fontWeight: FontWeight.w600);

  final foodListSubTitle = GoogleFonts.poppins(fontSize: 14, color: whiteColor, fontWeight: FontWeight.w400);
  final foodListText = GoogleFonts.poppins(fontSize: 14, color: blackColor, fontWeight: FontWeight.w400);
  final foodListSubText = GoogleFonts.poppins(fontSize: 12, color: blackColor, fontWeight: FontWeight.w300);
  
  final bottomSheetTitleWhite = GoogleFonts.poppins(fontSize: 14, color: whiteColor, fontWeight: FontWeight.w500);
  final bottomSheetTitleBlack = GoogleFonts.poppins(fontSize: 14, color: blackColor, fontWeight: FontWeight.w500);
  final bottomSheetSpeciesTextBlack = GoogleFonts.poppins(fontSize: 12, color: blackColor, fontWeight: FontWeight.w300);
  final bottomSheetSpeciesTextWhite = GoogleFonts.poppins(fontSize: 12, color: whiteColor, fontWeight: FontWeight.w300);

  final foodPageText = GoogleFonts.poppins(fontSize: 12, color: blackColor, fontWeight: FontWeight.w300);
  final foodPageBullet = GoogleFonts.poppins(fontSize: 12, color: blackColor, fontWeight: FontWeight.bold);
  final foodPageSubTitle = GoogleFonts.poppins(fontSize: 16, color: blackColor, fontWeight: FontWeight.w600);
  final calorieText = GoogleFonts.poppins(fontSize: 14, color: blackColor, fontWeight: FontWeight.w600);
}