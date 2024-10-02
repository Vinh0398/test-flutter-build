import 'package:flutter/material.dart';
import 'package:test_flutter_build/src/core/colors.dart';

class HeaderRouteWidget extends StatelessWidget {
  final double widgetHeight;
  final String titleRouteText;
  final String routeText;
  final TextStyle titleRouteStyle;
  final TextStyle routeStyle;
  final Function()? viewRouteTap;
  final String rightText;
  final TextStyle rightStyle;
  final EdgeInsets padding;

  const HeaderRouteWidget({
    super.key,
    required this.widgetHeight,
    required this.titleRouteText,
    required this.routeText,
    required this.titleRouteStyle,
    required this.routeStyle,
    this.viewRouteTap,
    required this.rightText,
    required this.rightStyle,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        height: widgetHeight,
        width: double.infinity,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _leftWidget(
                titleText: titleRouteText,
                routeText: routeText,
                titleStyle: titleRouteStyle,
                routeStyle: routeStyle),
            const Spacer(),
            _rightWidget(
              viewRouteTap,
              rightText,
              rightStyle,
            )
          ],
        ),
      ),
    );
  }

  Widget _leftWidget({
    required String titleText,
    required String routeText,
    required TextStyle titleStyle,
    required TextStyle routeStyle,
  }) {
    return RichText(
        text: TextSpan(style: titleStyle, children: [
      TextSpan(text: titleText),
      TextSpan(text: routeText, style: routeStyle),
    ]));
  }

  Widget _rightWidget(Function()? onTap, String text, TextStyle style) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
          color: primary40,
        )),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 4, bottom: 4),
              child: Text(
                text,
                style: style,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
              child: Image.asset(
                "res/images/arrow_orange_icon.png",
                width: 16,
                height: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
