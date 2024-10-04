import 'package:flutter/material.dart';

class LeftRightTextWidget extends StatelessWidget {
  final double widgetHeight;
  final String leftText;
  final String? rightText;
  final TextStyle leftStyle;
  final TextStyle? rightStyle;
  final String? image;
  final EdgeInsets padding;
  final Function()? onTap;
  const LeftRightTextWidget({
    super.key,
    required this.leftText,
    this.rightText,
    required this.leftStyle,
    this.rightStyle,
    this.image,
    required this.widgetHeight,
    required this.padding,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: SizedBox(
          height: widgetHeight,
          width: double.infinity,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            textWidget(leftText, leftStyle),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: imageWidget(image),
            ),
            textWidget(rightText, rightStyle),
          ],
        ),
        ),
      ),
    );
  }

  Widget textWidget(String? text, TextStyle? style) {
    if (text != null) {
      return Text(
        text,
        style: style,
      );
    } else {
      return Container();
    }
  }

  Widget imageWidget(String? image) {
    if (image != null) {
      if (image.contains("https:")) {
        return SizedBox(
          height: 24,
          width: 24,
          child: Image.network(
            image,
            fit: BoxFit.contain,
          ),
        );
      } else {
        return SizedBox(
          height: 24,
          width: 24,
          child: Image.asset(
            image,
            fit: BoxFit.contain,
          ),
        );
      }
    } else {
      return Container();
    }
  }
}
