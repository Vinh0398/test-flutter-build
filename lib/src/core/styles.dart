import 'package:flutter/material.dart';
import 'package:test_flutter_build/src/core/colors.dart';
import 'package:test_flutter_build/src/core/fonts.dart';

enum AppTextStyle {
  styleH1("H1"),
  styleH2("H2"),
  styleH3("H3"),
  styleH4("H4"),
  styleH5("H5"),
  styleH6("H6"),
  styleBody1("body1"),
  styleBody2("body2"),
  styleBody3("body3"),
  styleBody4("body4"),
  styleCaption1("caption1"),
  styleCaption2("caption2"),
  styleCaption3("caption3"),
  styleCaption4("caption4"),
  styleButton1("button1"),
  styleButton2("button2"),
  styleButton3("button3"),
  styleTitle1("title1"),
  styleTitle2("title2"),
  subHeadLine("subHeadline")
  ;
  final String value;
  const AppTextStyle(this.value);

  static AppTextStyle of(String value) {
    final textStyle = AppTextStyle.values.firstWhere((e) => e.value.contains(value));
    return textStyle;
  }

  TextStyle getTextStyle() {
    switch(this) {
      case AppTextStyle.styleH1:
        return AppStyles.styleH1;
      case AppTextStyle.styleH2:
        return AppStyles.styleH2;
      case AppTextStyle.styleH3:
        return AppStyles.styleH3;
      case AppTextStyle.styleH4:
        return AppStyles.styleH4;
      case AppTextStyle.styleH5:
        return AppStyles.styleH5;
      case AppTextStyle.styleH6:
        return AppStyles.styleH6;
      case AppTextStyle.styleBody1:
        return AppStyles.styleBody1;
      case AppTextStyle.styleBody2:
        return AppStyles.styleBody2;
      case AppTextStyle.styleBody3:
        return AppStyles.styleBody3;
      case AppTextStyle.styleBody4:
        return AppStyles.styleBody4;
      case AppTextStyle.styleCaption1:
        return AppStyles.styleCaption1;
      case AppTextStyle.styleCaption2:
        return AppStyles.styleCaption2;
      case AppTextStyle.styleCaption3:
        return AppStyles.styleCaption3;
      case AppTextStyle.styleCaption4:
        return AppStyles.styleCaption4;
      case AppTextStyle.styleButton1:
        return AppStyles.styleButton1;
      case AppTextStyle.styleButton2:
        return AppStyles.styleButton2;
      case AppTextStyle.styleButton3:
        return AppStyles.styleButton3;
      case AppTextStyle.styleTitle1:
        return AppStyles.styleTitle1;
      case AppTextStyle.styleTitle2:
        return AppStyles.styleTitle2;
      case AppTextStyle.subHeadLine:
        return AppStyles.subHeadLine;
    }
  }
}

class AppStyles {
  AppStyles._();
  static TextStyle styleH1 = const TextStyle(
      fontFamily: kFontGilroyBold,
      fontSize: 16,
      color: gray8,
      height: 1.25,
      fontWeight: FontWeight.w700);
  static TextStyle styleH2 = const TextStyle(
      fontFamily: kFontGilroyBold,
      fontSize: 24,
      color: gray8,
      height: 32 / 24,
      fontWeight: FontWeight.w700);
  static TextStyle styleH3 = const TextStyle(
      fontFamily: kFontGilroyBold,
      fontSize: 20,
      color: gray8,
      height: 1.6,
      fontWeight: FontWeight.w700);
  static TextStyle styleH4 = const TextStyle(
      fontFamily: kFontGilroyBold,
      fontSize: 18,
      color: gray8,
      height: 24 / 18,
      fontWeight: FontWeight.w700);
  static TextStyle styleH5 = const TextStyle(
      fontFamily: kFontGilroyBold,
      fontSize: 16,
      color: gray8,
      height: 1.5,
      fontWeight: FontWeight.w700);
  static TextStyle styleH6 = const TextStyle(
      fontFamily: kFontGilroyBold,
      fontSize: 14,
      color: gray90,
      height: 20 / 14,
      fontWeight: FontWeight.w700);

  static TextStyle styleBody1 = const TextStyle(
      fontFamily: kFontGilroyMedium,
      fontSize: 18,
      color: gray8,
      height: 24 / 18,
      fontWeight: FontWeight.w500);
  static TextStyle styleBody2 = const TextStyle(
      fontFamily: kFontGilroyMedium,
      fontSize: 16,
      color: gray8,
      height: 1.5,
      fontWeight: FontWeight.w500);
  static TextStyle styleBody3 = const TextStyle(
      fontFamily: kFontGilroyMedium,
      fontSize: 14,
      color: gray8,
      height: 20 / 14,
      fontWeight: FontWeight.w500);
  static TextStyle styleBody4 = const TextStyle(
      fontFamily: kFontGilroyMedium,
      fontSize: 12,
      color: gray8,
      height: 24 / 18,
      fontWeight: FontWeight.w500);

  static TextStyle styleCaption1 = const TextStyle(
      fontFamily: kFontGilroySemiBold,
      fontWeight: FontWeight.w700,
      fontSize: 16,
      color: neutralBlackColor,
      height: 1.5);
  static TextStyle styleCaption2 = const TextStyle(
      fontFamily: kFontGilroySemiBold,
      fontWeight: FontWeight.w600,
      fontSize: 14,
      color: neutralBlackColor,
      height: 20 / 14);
  static TextStyle styleCaption3 = const TextStyle(
      fontFamily: kFontGilroySemiBold,
      fontWeight: FontWeight.w600,
      fontSize: 12,
      color: neutralBlackColor,
      height: 16 / 12);
  static TextStyle styleCaption4 = const TextStyle(
      fontFamily: kFontGilroySemiBold,
      fontWeight: FontWeight.w600,
      fontSize: 10,
      color: neutralBlackColor,
      height: 1.6);

  static TextStyle styleButton1 = const TextStyle(
      fontFamily: kFontGilroyBold,
      fontWeight: FontWeight.w700,
      fontSize: 20,
      color: neutralBlackColor,
      height: 1.6);
  static TextStyle styleButton2 = const TextStyle(
      fontFamily: kFontGilroyBold,
      fontWeight: FontWeight.w700,
      fontSize: 16,
      color: neutralBlackColor,
      height: 1.5);
  static TextStyle styleButton3 = const TextStyle(
      fontFamily: kFontGilroyBold,
      fontWeight: FontWeight.w700,
      fontSize: 14,
      color: neutralBlackColor,
      height: 20 / 14);

  static TextStyle styleTitle1 = const TextStyle(
      fontFamily: kFontGilroyMedium,
      fontWeight: FontWeight.w400,
      fontSize: 12,
      color: neutralBlackColor,
      height: 20 / 14,
      letterSpacing: 0.5);
  static TextStyle styleTitle2 = const TextStyle(
      fontFamily: kFontGilroyMedium,
      fontWeight: FontWeight.w700,
      fontSize: 10,
      color: neutralBlackColor,
      height: 1.6,
      letterSpacing: 0.5);
  static TextStyle subHeadLine = const TextStyle(
    fontFamily: kFontGilroyMedium,
    fontWeight: FontWeight.w600,
    fontSize: 15,
    color: neutralBlackColor,
    height: 20 / 14,
    letterSpacing: 0.5);
}

