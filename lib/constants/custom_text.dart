import 'package:flutter/material.dart';
import 'package:habit_heat/constants/constants.dart';
import 'package:habit_heat/constants/size_config.dart';

Widget CustomText({
  String? text,
  double? fontSize,
  FontWeight? fontWeight,
  Color? color = kTextColor,
  TextAlign? position,
}) {
  return Text(
    '$text',
    style: TextStyle(
      color: color,
      fontSize: getProportionateScreenWidth(
        fontSize!,
      ),
      fontWeight: fontWeight,
    ),
    textAlign: position,
  );
}
