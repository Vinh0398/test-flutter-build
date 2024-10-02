import 'package:flutter/foundation.dart';
import 'dart:async';
class Debouncer {
  final Duration duration;
  Timer? _timer;

  Debouncer({ required this.duration });

  run(VoidCallback action) {
    if (_timer?.isActive == true) {
      _timer?.cancel();
    }
    _timer = Timer(duration, action);
  }

  void cancel() {
    _timer?.cancel();
  }
}