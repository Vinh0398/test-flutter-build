
import 'package:test_flutter_build/src/data/datasource/remote/fail_order/request_fail_order_data_source.dart';
import 'package:test_flutter_build/src/data/datasource/remote/params/fail_order_param.dart';

abstract class FailOrderDataSource {
  Future<Map<String, dynamic>> failOrder(FailOrderParam param);
}

class FailOrderRepository extends FailOrderDataSource {
  RequestFailOrderDataSource requestFailOrderDataSource;
  FailOrderRepository({required this.requestFailOrderDataSource});
  @override
  Future<Map<String, dynamic>> failOrder(FailOrderParam param) async {
    final result = await requestFailOrderDataSource.failOrder(param);
    return result;
  }
}