import 'package:flutter/material.dart';
import 'package:test_flutter_build/src/core/colors.dart';
import 'package:test_flutter_build/src/core/styles.dart';
import 'package:test_flutter_build/src/presentation/views/widgets/commons/left_right_text_widget.dart';

class PaymentDetailWidget extends StatelessWidget {
  final String payDetailTitle;
  final String moneyString;
  final TextStyle moneyTextStyle;
  final String paymentDetail;
  final String paymentIcon;

  const PaymentDetailWidget({
    required this.payDetailTitle,
    required this.moneyString,
    required this.moneyTextStyle,
    required this.paymentDetail,
    required this.paymentIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleWidget(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: payDetail(),
          ),
          paymentDetailWidget()
        ],
      ),
    );
  }

  Widget titleWidget() {
    return Text(
      "Thanh toán",
      style: AppStyles.styleH4.copyWith(color: gray90),
    );
  }

  Widget payDetail() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        imageWidget(),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: payDesc(),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 0),
          child: Text(
            moneyString,
            style: moneyTextStyle,
          ),
        ),
      ],
    );
  }

  Widget imageWidget() {
    return SizedBox(
      height: 40,
      width: 40,
      child: Image.asset(
        "res/images/cash-collect.png",
        fit: BoxFit.cover,
      ),
    );
  }

  Widget payDesc() {
    return Text(
      payDetailTitle,
      style: AppStyles.styleBody3.copyWith(color: gray90),
    );
  }

  Widget paymentDetailWidget() {
    return LeftRightTextWidget(
      leftText: "Hình thức thanh toán",
      leftStyle: AppStyles.styleBody3,
      rightText: paymentDetail,
      rightStyle: AppStyles.styleH6.copyWith(color: gray90),
      widgetHeight: 24,
      padding: const EdgeInsets.only(bottom: 16), image: paymentIcon,
    );
  }
}
