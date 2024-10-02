import 'package:flutter/material.dart';
import 'package:test_flutter_build/src/core/colors.dart';
import 'package:test_flutter_build/src/core/styles.dart';

Widget primaryButton(String text,
    {VoidCallback? onTap,
    double? padding = 12,
    Widget? leftIcon,
    Widget? rightIcon,
    bool? enabled = true,
    Color? color = primaryColor,
    Color? textColor = Colors.white}) {
  return InkWell(
    onTap: enabled == true ? onTap : null,
    child: Container(
      width: double.infinity,
      height: 48,
      alignment: Alignment.center,
      padding: EdgeInsets.all(padding ?? 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: enabled == true ? color : gray4
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(
            visible: leftIcon != null,
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: leftIcon ??
                  const SizedBox(
                    width: 0,
                    height: 0,
                  ),
            ),
          ),
          Text(
            text,
            style: AppStyles.styleButton3.copyWith(color: textColor)),
          Visibility(
            visible: rightIcon != null,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: rightIcon ??
                  const SizedBox(
                    width: 0,
                    height: 0,
                  ),
            ),
          ),
        ],
      ),
    ),
  );
  }