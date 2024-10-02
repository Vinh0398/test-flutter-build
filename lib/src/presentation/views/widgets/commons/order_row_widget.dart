import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderRowWidget extends StatelessWidget {
  final Color borderColor;
  final String leftIcon;
  final String headerText;
  final TextStyle headerTextStyle;
  final String titleText;
  final TextStyle titleTextStyle;
  final String subtitleText;
  final TextStyle subtitleTextStyle;
  final Function()? onTap;
  final EdgeInsets padding;

  const OrderRowWidget({
    super.key,
    required this.borderColor,
    required this.leftIcon,
    required this.headerText,
    required this.headerTextStyle,
    required this.titleText,
    required this.titleTextStyle,
    required this.subtitleText,
    required this.subtitleTextStyle,
    required this.padding,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                child: Text(headerText, style: headerTextStyle),
              ),
              Row(
                children: [
                  SizedBox(width: 20, child: _iconWidget(leftIcon)),
                  const SizedBox(width: 10),
                  Expanded(
                      child: SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _textWidget(titleText, titleTextStyle),
                        _textWidget(subtitleText, subtitleTextStyle),
                      ],
                    ),
                  )),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: SizedBox(
                      width: 20,
                      child: _iconWidget("res/images/ic_arrow_right.png"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        ),
      ),
    );
  }

  Widget _iconWidget(String image) {
    if (image != "") {
      return Image.asset(
        image,
        width: 16,
        height: 16,
      );
    } else {
      return Container();
    }
  }

  Widget _textWidget(String text, TextStyle style) {
    return Text(
      text,
      style: style,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
