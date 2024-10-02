import 'package:flutter/material.dart';
import 'package:test_flutter_build/src/core/colors.dart';
import 'package:test_flutter_build/src/core/styles.dart';

class InformationClientWidget extends StatelessWidget {
  final String title;
  final String? imageUrl;
  final String userName;
  final String userType;
  final Function()? onCallTap;
  final Function()? onChatTap;

  const InformationClientWidget({
    super.key,
    required this.title,
    this.imageUrl,
    required this.userName,
    required this.userType,
    this.onCallTap,
    this.onChatTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: titleWidget(title: title),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
          ),
          child: inforWidget(
              imageUrl: imageUrl, userName: userName, userType: userType),
        ),
        const Divider(
          thickness: 1,
          color: gray2,
        ),
        actionWidget(),
         const Divider(
          thickness: 1,
          color: gray2,
        ),
      ],
    );
  }

  Widget titleWidget({required String title}) {
    return Text(
      title,
      style: AppStyles.styleH4.copyWith(color: gray90),
    );
  }

  Widget inforWidget({
    String? imageUrl,
    required String userName,
    required String userType,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        avatarWidget(imageUrl: imageUrl),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: clientInfo(name: userName, type: userType),
        )
      ],
    );
  }

  Widget avatarWidget({String? imageUrl}) {
    if (imageUrl != null && imageUrl != "") {
      return SizedBox(
        width: 30,
        height: 30,
        child: CircleAvatar(
          radius: 30,
          foregroundColor: gray2,
          child: Image.network(
            imageUrl!,
            width: 24,
            height: 24,
          ),
        ),
      );
    } else {
      return SizedBox(
        width: 30,
        height: 30,
        child: CircleAvatar(
          radius: 30,
          foregroundColor: gray2,
          child: Image.asset(
            "res/images/avatar_icon.png",
            width: 24,
            height: 24,
          ),
        ),
      );
    }
  }

  Widget clientInfo({required String name, required String type}) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: AppStyles.styleBody3.copyWith(color: neutralBlackColor),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            type,
            style: AppStyles.styleTitle1.copyWith(color: warmGrey),
          ),
        )
      ],
    );
  }

  Widget actionWidget() {
    return SizedBox(
      height: 59,
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: actionItemWidget(
                nameAction: 'Gọi điện', icon: "res/images/ic-caller.png", onTap: onCallTap),
          ),
          const VerticalDivider(
            thickness: 1,
            color: gray4,
            indent: 16,
            endIndent: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: actionItemWidget(nameAction: "Nhắn tin", icon: "res/images/ic-message.png", onTap: onChatTap),
          ),
        ],
      ),
    );
  }

  Widget actionItemWidget({
    Function()? onTap,
    required String nameAction,
    required String icon,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                icon,
                width: 24,
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  nameAction,
                  style: AppStyles.subHeadLine.copyWith(color: gray90),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
