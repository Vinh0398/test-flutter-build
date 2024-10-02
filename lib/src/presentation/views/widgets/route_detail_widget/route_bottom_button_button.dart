import 'package:flutter/material.dart';
import 'package:test_flutter_build/src/core/colors.dart';
import 'package:test_flutter_build/src/presentation/views/widgets/commons/bottom_button_widget.dart';

class RouteBottomButtonsWidget extends StatelessWidget {
  final String failBtnTitle;
  final TextStyle failBtnTextStyle;
  final Function()? failTap;
  final bool needShowFailBtn;
  final String completeBtnTitle;
  final TextStyle completeBtnTextStyle;
  final Function()? completeTap;

  const RouteBottomButtonsWidget({
    super.key,
    required this.failBtnTitle,
    required this.failBtnTextStyle,
    required this.needShowFailBtn,
    required this.completeBtnTitle,
    required this.completeBtnTextStyle,
    this.failTap,
    this.completeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: needShowFailBtn,
          child: Flexible(
            child: btnWidget(
              title: failBtnTitle,
              style: failBtnTextStyle,
              btnColor: gray4,
              onTap: failTap,
            ),
          ),
        ),
        Flexible(
          child: btnWidget(
            title: completeBtnTitle,
            style: completeBtnTextStyle,
            btnColor: primary50,
            onTap: completeTap,
          ),
        ),
      ],
    );
  }

  Widget btnWidget(
      {required String title,
      required TextStyle style,
      Function()? onTap,
      required Color btnColor}) {
    return BottomButtonWidget(
      widgetHeight: 80,
      buttonHeight: 70,
      buttonPadding: EdgeInsets.symmetric(horizontal: 4),
      buttonColor: btnColor,
      buttonTitleStyle: style,
      buttonTitle: title,
      onTap: onTap,
    );
  }
}
