import 'package:flutter/material.dart';
import 'package:test_flutter_build/src/core/colors.dart';
import 'package:test_flutter_build/src/core/styles.dart';

class ProofImagePopup extends StatefulWidget {
  const ProofImagePopup({super.key});

  @override
  State<ProofImagePopup> createState() => _ProofImagePopupState();
}

class _ProofImagePopupState extends State<ProofImagePopup> {
  int maxImageItem = 15;
  int currentListItem = 1;
  List<String> imageUploaded = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Phương thức xác nhận hình ảnh",
          style: AppStyles.styleH3.copyWith(color: gray90),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: listImageWidget(),
        ),

      ],
    );
  }

  Widget listImageWidget() {
    return ListView.builder(
      itemCount: currentListItem,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        final image = imageUploaded[index];
        imageItemWidget(
          imageUrl: image,
          onTapAdd: () => handleAddImage(),
          onTapPreview: () {},
        );
      },
    );
  }

  Widget imageItemWidget(
      {required String? imageUrl,
      Function()? onTapAdd,
      Function()? onTapPreview}) {
    if (imageUrl != null && imageUrl != "") {
      return GestureDetector(
        onTap: onTapPreview,
        child: SizedBox(
          height: 60,
          width: 50,
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: onTapAdd,
        child: SizedBox(
          height: 60,
          width: 50,
          child: Image.asset(
            "res/images/ic-add-photo.png",
            fit: BoxFit.cover,
          ),
        ),
      );
    }
  }

  Widget bottomButtonWidget() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

      ],
    );
  }

  void handleAddImage() {}
}
