import 'package:flutter/material.dart';

class ImageTextWidget extends StatelessWidget {
  final Function()? onTap;
  final EdgeInsets padding;
  final double widgetHeight;
  final String iconUrl;
  final String leftText;
  final String rightText;
  final TextStyle leftTextStyle;
  final TextStyle rightTextStyle;

  const ImageTextWidget({
    super.key,
    this.onTap,
    required this.padding,
    required this.widgetHeight,
    required this.iconUrl,
    required this.leftText,
    required this.rightText,
    required this.leftTextStyle,
    required this.rightTextStyle,
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
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: imageWidget(image: iconUrl),
              ),
              textWidget(leftText, leftTextStyle),
              const Spacer(),
              textWidget(rightText, rightTextStyle),
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

  Widget imageWidget({String? image}) {
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
