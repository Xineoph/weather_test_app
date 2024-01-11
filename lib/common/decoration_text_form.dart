import 'package:flutter/material.dart';
import 'package:weather_test_app/common/colors.dart';
import 'package:weather_test_app/common/text_styles.dart';

InputDecoration inputDecorationTextForm() {
  return InputDecoration(
    border: InputBorder.none,
    fillColor: CustomColors.formColor,
    filled: true,
    hintStyle: textStyleInter16Black(),
  );
}
