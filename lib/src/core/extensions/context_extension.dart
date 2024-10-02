import 'package:flutter/cupertino.dart';

extension ContextExtension on BuildContext {

  double screenWidth() => MediaQuery.of(this).size.width;

  double screenHeight() => MediaQuery.of(this).size.height;
}