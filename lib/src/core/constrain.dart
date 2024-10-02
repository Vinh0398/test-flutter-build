import 'dart:ui';
import 'package:flutter/material.dart';

class AppConstrain {
  AppConstrain._();

  static FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
  static Size size = view.physicalSize;

  static double scaleHeight = size.height / 667.0 + 0;
  static double scaleWidth = size.width / 375.0 + 0;
}