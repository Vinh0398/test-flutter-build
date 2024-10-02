import 'dart:convert';

import 'package:aha_flutter_core/utils/logger.dart';
import 'package:flutter/services.dart';
import 'package:test_flutter_build/src/data/model/response/order_detail/order_detail_model.dart';
import 'package:test_flutter_build/src/data/model/response/route_path_model.dart';

const channel = MethodChannel("channelCommon");

class PlatformChannelMethod {
  PlatformChannelMethod._();

  static Future getConfig() async {
    try {
      final config = await channel.invokeMethod('setConfig');
      return jsonDecode(config);
    } catch (e) {
      return null;
    }
  }

  static Future openRouteView(OrderDetailModel? order) async {
    if (order != null) {
      try {
        Map<String, dynamic> orderJson;
        List<Map<String, dynamic>> pathsJson = [];
        orderJson = order.toJson();
        final orderPaths = order.path;
        for (var e in orderPaths) {
          final pathJsonItem = e.toJson();
          pathsJson.add(pathJsonItem);
        }
        final obj = {"order": orderJson, "paths": pathsJson};

        return await channel.invokeMethod('openRouteView', jsonEncode(obj));
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future dismissView({required String orderId}) async {
    try {
      final config = await channel.invokeMethod('dismissView', orderId);
      return jsonDecode(config);
    } catch (e) {
      return null;
    }
  }

  static Future navigateToRouteDetail(
      {required OrderDetailModel order, int? routeIndex}) async {
    try {
      Map<String, dynamic> orderJson;
      orderJson = order.toJson();
      final Map<String, dynamic> obj = {"order": orderJson};
      if (routeIndex != null) {
        obj.addAll({"route_index": routeIndex});
      }
      return await channel.invokeMethod('openRouteDetail', jsonEncode(obj));
    } catch (e) {
      return null;
    }
  }

  static Future<RoutePathModel?> getCurrentLocation() async {
    try {
      final config = await channel.invokeMethod('getCurrentLocation');
      if (config == null) {
        return null;
      } else {
        final json = jsonDecode(config);
        return RoutePathModel.create(json);
      }
    } catch (e) {
      logger.e("Error", e);
      return null;
    }
  }

  static Future openReportView(OrderDetailModel? order) async {
    if (order != null) {
      try {
        Map<String, dynamic> orderJson;
        List<Map<String, dynamic>> pathsJson = [];
        orderJson = order.toJson();
        final orderPaths = order.path;
        for (var e in orderPaths) {
          final pathJsonItem = e.toJson();
          pathsJson.add(pathJsonItem);
        }
        final obj = {"order": orderJson, "paths": pathsJson};

        return await channel.invokeMethod('openReportView', jsonEncode(obj));
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }
}
