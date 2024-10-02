import 'package:flutter/material.dart';

class InfoTextWidget extends StatelessWidget {
  final String text;
  final TextStyle style;
  final String? icon;
  final Function()? onTap;

  const InfoTextWidget({
    super.key,
    required this.text,
    required this.style,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _textWidget(text, style),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: _infoIconWidget(
            icon,
            onTap,
          ),
        ),
      ],
    );
  }

  Widget _textWidget(String text, TextStyle style) {
    return Text(
      text,
      style: style,
    );
  }

  Widget _infoIconWidget(
    String? image,
    Function()? onTap,
  ) {
    if (image != null) {
      return InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 30,
          width: 30,
          child: Center(
            child: Image.asset(
              image,
              width: 16,
              height: 16,
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
