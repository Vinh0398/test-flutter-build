import 'package:flutter/material.dart';

class BottomButtonWidget extends StatelessWidget {
  final double widgetHeight;
  final double buttonHeight;
  final EdgeInsets buttonPadding;
  final String buttonTitle;
  final Function()? onTap;
  final Color buttonColor;
  final TextStyle buttonTitleStyle;

  const BottomButtonWidget({
    super.key,
    required this.widgetHeight,
    required this.buttonHeight,
    required this.buttonPadding,
    this.onTap,
    required this.buttonColor,
    required this.buttonTitleStyle,
    required this.buttonTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: buttonHeight,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: buttonPadding,
        child: FloatingActionButton(
          onPressed: onTap,
          backgroundColor: buttonColor,
          shape: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              )),
          elevation: 0,
          child: Center(
            child: Text(
              buttonTitle,
              style: buttonTitleStyle,
            ),
          ),
        ),
      ),
    );
  }
}
