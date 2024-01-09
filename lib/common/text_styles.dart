import 'package:flutter/material.dart';
import 'package:weather_test_app/common/colors.dart';

TextStyle textStyleInter16Black() {
  return const TextStyle(
    fontFamily: 'Inter',
    color: CustomColors.textColor,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
}

TextStyle textStyleInter16Green() {
  return const TextStyle(
    fontFamily: 'Inter',
    color: CustomColors.buttonColor,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
}

TextStyle textStyleInter16Black1() {
  return const TextStyle(
    fontFamily: 'Inter',
    color: CustomColors.textButtonColor,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
}

TextStyle textStyleInter40Black() {
  return const TextStyle(
    fontFamily: 'Inter',
    color: CustomColors.textColor,
    fontSize: 40,
    fontWeight: FontWeight.w300,
  );
}

TextStyle textStyleInter20ValuesBlack() {
  return const TextStyle(
    fontFamily: 'Inter',
    color: CustomColors.textColor,
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );
}

TextStyle textStyleInter20Black() {
  return const TextStyle(
    fontFamily: 'Inter',
    color: CustomColors.textColor,
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );
}

InputDecoration inputDecorationTextForm() {
  return InputDecoration(
    border: InputBorder.none,
    fillColor: CustomColors.formColor,
    filled: true,
    hintStyle: textStyleInter16Black(),
  );
}
