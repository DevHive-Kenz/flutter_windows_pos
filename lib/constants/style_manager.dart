import 'package:flutter/material.dart';
import 'font_manager.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle _getTextStyle(
    double fontSize,  FontWeight fontWeight, Color color,TextDecoration deco) {
  return GoogleFonts.poppins(

    textStyle: TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      decoration: deco,

    )
  );
}

// regular style
TextStyle getRegularStyle(
    {double fontSize = FontSize.s12, required Color color,TextDecoration decoration = TextDecoration.none}) {
  return _getTextStyle(
      fontSize, FontWeightManager.regular, color,decoration);
}

// light text style
 TextStyle getLightStyle(
    {double fontSize = FontSize.s12, required Color color,TextDecoration decoration = TextDecoration.none}) {
  return _getTextStyle(
      fontSize,  FontWeightManager.light, color,decoration);
}
// bold text style

TextStyle getBoldStyle({double fontSize = FontSize.s12, required Color color,TextDecoration decoration = TextDecoration.none}) {
  return _getTextStyle(
      fontSize, FontWeightManager.bold, color,decoration);
}

// semi bold text style
TextStyle getSemiBoldStyle(
    {double fontSize = FontSize.s12, required Color color,TextDecoration decoration = TextDecoration.none}) {
  return _getTextStyle(
      fontSize,  FontWeightManager.semiBold, color,decoration);
}

// medium text style

TextStyle getMediumStyle(
    {double fontSize = FontSize.s12, required Color color,TextDecoration decoration = TextDecoration.none}) {
  return _getTextStyle(
      fontSize,  FontWeightManager.medium, color,decoration);
}
