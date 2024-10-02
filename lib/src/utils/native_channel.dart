import 'dart:convert';

import 'package:flutter/services.dart';

const channel = MethodChannel("channelNative");

class NativeChannel {

  Future getOrderIdFromNative({required Function(String) onReceived}) async {
    String orderId = "";
    channel.setMethodCallHandler((call) async {
      if (call.method == 'orderId') {
        if (call.arguments != null) {
          dynamic jsonData = jsonDecode(call.arguments);
          Map<String, dynamic> jsonObj = Map<String, String>.from(jsonData);
          orderId = await jsonObj["order_id"];
          print("------> is get from native $orderId");
          onReceived(orderId);
        }
      }
    });
  }
}