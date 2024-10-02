import 'package:flutter/material.dart';
import 'package:test_flutter_build/src/core/colors.dart';
import 'package:test_flutter_build/src/core/styles.dart';

class RatingWidget extends StatelessWidget {
  final String? avatarUrl;
  final String userName;
  final TextStyle nameStyle;
  final int starRated;

  const RatingWidget({
    super.key,
    this.avatarUrl,
    required this.userName,
    required this.starRated,
    required this.nameStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          avatarWidget(imageUrl: avatarUrl),
          textWidget(text: userName, style: nameStyle),
          ratingWidget(ratingNumber: starRated),
          textWidget(text: getRatingResult(), style: AppStyles.styleH4),
        ],
      ),
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

  Widget textWidget({
    required String text,
    required TextStyle style,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Text(
        text,
        style: style,
      ),
    );
  }

  Widget ratingWidget({required int ratingNumber}) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: SizedBox(
        height: 30,
        width: double.infinity,
        child: Center(
          child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                if ((index + 1) <= ratingNumber) {
                  return SizedBox(
                    width: 24,
                    height: 24,
                    child: Image.asset(
                      "res/images/star_selected_icon.png",
                      fit: BoxFit.cover,
                    ),
                  );
                } else {
                  return SizedBox(
                    width: 24,
                    height: 24,
                    child: Image.asset(
                      "res/images/star_unselected_icon.png",
                      fit: BoxFit.cover,
                    ),
                  );
                }
              }, separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(width: 16,);
          },),
        ),
      ),
    );
  }

  String getRatingResult() {
    switch (starRated) {
      case == 1:
        return "Rất tệ";
      case == 2:
        return "Tệ";
      case == 3:
        return "Không hài lòng";
      case == 4:
        return "Bình thường";
      case == 5:
        return "Tốt";
      default:
        return "";
    }
  }
}
