import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoutePathWidget extends StatelessWidget {
  final Color borderColor;
  final String leftIcon;
  final String path;
  final TextStyle pathStyle;
  final EdgeInsets padding;
  final Function()? onPathTap;

  const RoutePathWidget({
    super.key,
    required this.borderColor,
    required this.leftIcon,
    required this.path,
    required this.pathStyle,
    required this.padding,
    this.onPathTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPathTap,
      child: Padding(
        padding: padding,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: borderColor,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 4,
                    right: 12,
                  ),
                  child: _iconWidget(leftIcon),
                ),
                Expanded(
                  child: _textWidget(path, pathStyle),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 8),
                  child: _iconWidget("res/images/ic_arrow_right.png"),
                ),
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
