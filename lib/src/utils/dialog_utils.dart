import 'package:flutter/material.dart';
import 'package:test_flutter_build/src/core/styles.dart';

import '../core/colors.dart';
import '../presentation/views/widgets/commons/custom_views.dart';

class DialogUtils {

  DialogUtils._();

  // static AlertDialog showServiceNotSupportDialog({
  //   required BuildContext context,
  //   GestureTapCallback? onTap
  // }) {
  //   AlertDialog dialog = AlertDialog(
  //     insetPadding: const EdgeInsets.only(left: 16, right: 16),
  //     content: Container(
  //       decoration: const BoxDecoration(
  //         shape: BoxShape.rectangle,
  //         color: Colors.white,
  //         borderRadius: BorderRadius.all(Radius.circular(4)),
  //       ),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.stretch,
  //         mainAxisSize: MainAxisSize.min,
  //         children: <Widget>[
  //           Text("title_popup_support_service".tr(), style: AppStyles.styleH4),
  //           const SizedBox(height: 12,),
  //           Text("content_popup_support_service".tr(), style: styleBody3,),
  //           const SizedBox(height: 16,),
  //           InkWell(
  //             onTap: () {
  //               Navigator.pop(context);
  //               onTap?.call();
  //             },
  //             child: Container(
  //               height: 48,
  //               alignment: Alignment.center,
  //               decoration: const BoxDecoration(
  //                 color: orange,
  //                 borderRadius: BorderRadius.all(Radius.circular(4)),
  //               ),
  //               child: Text(
  //                 "change_location".tr(),
  //                 style: styleButton3.copyWith(color: Colors.white),
  //                 textAlign: TextAlign.center,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  //   showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (context) => dialog);
  //   return dialog;
  // }

  // static AlertDialog showOnGoingOrderDialog({
  //   required BuildContext context,
  //   GestureTapCallback? onTap
  // }) {
  //   return showPrimaryDialog(
  //     context: context,
  //     title: "cannot_book_order_this_time".tr(),
  //     content: "please_complete_current_order".tr(),
  //     positiveTitle: "got_it".tr(),
  //     onPositiveTap: onTap,
  //     dismissible: false
  //   );
  // }

  static AlertDialog showPrimaryDialog({
    required BuildContext context,
    String? headerImage,
    String? title,
    required String content,
    String? negativeTitle,
    GestureTapCallback? onNegativeTap,
    required String positiveTitle,
    GestureTapCallback? onPositiveTap,
    bool dismissible = true
  }) {
    AlertDialog dialog = AlertDialog(
      insetPadding: const EdgeInsets.only(left: 16, right: 16),
      contentPadding: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4)
      ),
      content: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            (() {
              if (headerImage != null) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 240),
                    child: Image.asset(headerImage),
                  ),
                );
              } else {
                return Container();
              }
            })(),
            title != null ? Text(title, style: AppStyles.styleH4,) : Container(),
            Padding(
              padding: EdgeInsets.only(top: 12, bottom: 16),
              child: Text(content, style: AppStyles.styleBody3,),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                (() {
                  if (negativeTitle != null) {
                    return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: primaryButton(negativeTitle,
                              color: gray15,
                              textColor: secondary70,
                              onTap: () {
                                Navigator.pop(context);
                                onNegativeTap?.call();
                              }
                          ),
                        )
                    );
                  } else {
                    return Container();
                  }
                })(),
                Expanded(
                  child: primaryButton(positiveTitle,
                      onTap: () {
                        Navigator.pop(context);
                        onPositiveTap?.call();
                      }
                  )
                )
              ],
            )
          ],
        ),
      ),
    );
    showDialog(
        barrierDismissible: dismissible,
        context: context,
        builder: (context) {
          return WillPopScope(
            child: dialog,
            onWillPop: () => Future.value(dismissible),
          );
        });
    return dialog;
  }
}