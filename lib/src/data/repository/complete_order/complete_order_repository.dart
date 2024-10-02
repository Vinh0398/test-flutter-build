import 'package:test_flutter_build/src/data/datasource/remote/complete_order/request_complete_order_data_source.dart';
import 'package:test_flutter_build/src/data/datasource/remote/params/complete_order_param.dart';

abstract class CompleteOrderDataSource {
  Future<Map<String, dynamic>> completeOrder({required CompleteOrderParam param});
}

class CompleteOrderRepository extends CompleteOrderDataSource {
  final RequestCompleteOrderDataSource requestComplete;

  CompleteOrderRepository({required this.requestComplete});

  @override
  Future<Map<String, dynamic>> completeOrder({required CompleteOrderParam param}) async {
    final result = await requestComplete.completeOrder(param: param);
    return result;
  }

}