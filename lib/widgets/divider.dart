import 'package:flutter/material.dart';
import 'package:log_in/utils/color_constants.dart';

Widget gradientDivider(context) {
  return Center(
    child: Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: 1,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorConstant.white,
            ColorConstant.slate,
            ColorConstant.white,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
    ),
  );
}
