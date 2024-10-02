import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final TextStyle style;
  final EdgeInsets padding;

  const TextWidget({
    super.key,
    required this.text,
    required this.style,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: padding,
        child: Text(
          text,
          style: style,
        ));
  }
}
