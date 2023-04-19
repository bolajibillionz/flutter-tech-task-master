import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import '../size_config.dart';

Text createCustomText({
  required String inputText,
  required double fontSize,
  required FontWeight weight,
  required Color textColor,
}) {
  return Text(
    inputText,
    style: TextStyle(
        fontSize: getProportionateScreenWidth(fontSize),
        fontWeight: weight,
        color: textColor),
  );
}
