import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/styles.dart';
import '../../../../data/model/entity/order_sever_driven_ui_entity/section_entity/section_data_entity.dart';

class HeaderSectionWidget extends StatelessWidget {
  final List<SectionDataEntity>? data;
  final Function()? onTap;
  final EdgeInsets padding;

  const HeaderSectionWidget({
    Key? key,
    required this.data,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleData = data?.firstWhere((e) => e.type == "title", orElse: () => SectionDataEntity());
    final descriptionData = data?.firstWhere((e) => e.type == "description", orElse: () => SectionDataEntity());

    return Padding(
      padding: padding,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black54,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _textWidget(
                  titleData?.value ?? "",
                  _getTextStyle(titleData?.styles?.firstWhere((e) => e.Key == "style")?.Value ?? "body3"),
                ),
                const SizedBox(height: 4),
                _textWidget(
                  descriptionData?.value ?? "",
                  _getTextStyle(descriptionData?.styles?.firstWhere((e) => e.Key == "style")?.Value ?? "subHeadline"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textWidget(String text, TextStyle style) {
    return Text(
      text,
      style: style,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  TextStyle _getTextStyle(String styleName) {
    return AppTextStyle.of(styleName).getTextStyle();
  }
}
