import 'package:flutter/material.dart';
import 'package:weather_test_app/common/colors.dart';
import 'package:weather_test_app/common/text_styles.dart';

Widget buildElevatedButton(
  String buttonText,
  VoidCallback onPressed,
) {
  return Center(
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomColors.buttonColor,
        fixedSize: const Size(184, 40),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),
      child: Text(
        buttonText,
        style: textStyleInter16Black1(),
      ),
    ),
  );
}
