import 'package:flutter/material.dart';

import '../../../../core/colors.dart';

class LoadingDialog {

  LoadingDialog(this.context, this.route);

  final BuildContext context;
  final DialogRoute route;
  static LoadingDialog? _dialog;


  static void show(BuildContext context) {
    if (_dialog == null) {
      final route = DialogRoute(
          context: context,
          builder: (_) {
            return WillPopScope(
              child: const Center(
                child: CircularProgressIndicator(
                  color: primary60,
                ),
              ),
              onWillPop: () => Future.value(false),
            );
          },
          barrierDismissible: false,
      );
      _dialog = LoadingDialog(context, route);
      Navigator.of(context).push(route);
    }
  }

  static void showTransparent(BuildContext context) {
    if (_dialog == null) {
      final route = DialogRoute(
          context: context,
          builder: (_) {
            return Container(color: Colors.transparent,);
          },
          barrierDismissible: false,
          barrierColor: Colors.transparent
      );
      _dialog = LoadingDialog(context, route);
      Navigator.of(context).push(route);
    }
  }

  static void hide() {
    if (_dialog != null) {
      Navigator.of(_dialog!.context).removeRoute(_dialog!.route);
      _dialog = null;
    }
  }
}