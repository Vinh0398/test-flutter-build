import 'package:flutter/material.dart';
import 'package:test_flutter_build/src/core/colors.dart';
import 'package:test_flutter_build/src/core/styles.dart';

class ExtendInformationWidget extends StatefulWidget {
  final String userName;
  final double rated;
  final bool hidden;

  const ExtendInformationWidget({
    super.key,
    required this.userName,
    required this.rated,
    required this.hidden
  });

  @override
  State<ExtendInformationWidget> createState() =>
      _ExtendInformationWidgetState();
}

class _ExtendInformationWidgetState extends State<ExtendInformationWidget> {
  bool _customTitleExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.hidden,
      child: ExpansionTile(
        title: Text(
          "Thông tin người tạo đơn",
          style: AppStyles.styleH1.copyWith(color: gray90),
        ),
        trailing: Image.asset(
          _customTitleExpanded
              ? "res/images/ic_up_arrow.png"
              : "res/images/ic_down_arrow.png",
          width: 24,
          height: 24,
        ),
        children: [information()],
        onExpansionChanged: (bool expanded) {
          setState(() {
            _customTitleExpanded = expanded;
          });
        },
      ),
    );
  }

  Widget information() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          avatarWidget(),
          informationWidget(
            userName: widget.userName,
            rated: widget.rated,
          ),
          Spacer(),
          Image.asset(
            "res/images/ic_call_orange.png",
            width: 32,
            height: 32,
          ),
        ],
      ),
    );
  }

  Widget avatarWidget({String? imageUrl}) {
    if (imageUrl != null && imageUrl != "") {
      return SizedBox(
        width: 30,
        height: 30,
        child: Image.network(
          imageUrl,
          width: 30,
          height: 30,
        ),
      );
    } else {
      return SizedBox(
        width: 30,
        height: 30,
        child: Image.asset(
          "res/images/avatar_icon.png",
          width: 30,
          height: 30,
        ),
      );
    }
  }

  Widget informationWidget({
    required String userName,
    required double rated,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            userName,
            style: AppStyles.styleH6.copyWith(color: gray90),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "$rated",
                style: AppStyles.styleBody4.copyWith(color: gray2),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 2),
                child: Icon(
                  Icons.star,
                  size: 12,
                  color: red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
