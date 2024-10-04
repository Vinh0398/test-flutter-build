import 'package:flutter/services.dart';
import 'package:test_flutter_build/src/data/model/response/order_sever_driven_ui/oder_sever_driven_ui_model.dart';
import 'dart:convert';

import 'package:test_flutter_build/src/data/repository/order_sever_driven_ui/order_sever_driven_ui_repository.dart';

class GetSeverUIDataSource extends OrderSeverDrivenUIDataSource {


  @override
  Future<OrderSeverDrivenUIModel> getSeverUI() async {
    final data = await rootBundle.loadString("lib/src/data/datasource/local/order-SDUI-mockdata.json");
    final json = jsonDecode(data);
    final result = OrderSeverDrivenUIModel.fromJson(json);
    return result;
  }
}