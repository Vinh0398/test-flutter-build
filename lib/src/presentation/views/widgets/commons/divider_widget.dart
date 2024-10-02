import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  final double height;
  final Color color;
  final double horizontalPadding;
  final double verticalPadding;

  const DividerWidget({
    super.key,
    required this.height,
    required this.color,
    required this.horizontalPadding,
    required this.verticalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: Divider(
        thickness: height,
        color: color,
      ),
    );
  }
}
