import 'package:test_flutter_build/src/data/datasource/remote/params/accept_order_param.dart';

import '../../datasource/remote/accept_order/request_accept_order_data_source.dart';

abstract class AcceptOrderDataSource {
  Future<Map<String, dynamic>> acceptOrder(AcceptOrderParam param);
}

class AcceptOrderRepository extends AcceptOrderDataSource {
  RequestAcceptOrderDataSource requestAcceptOrderDataSource;
  AcceptOrderRepository({required this.requestAcceptOrderDataSource});

  @override
  Future<Map<String, dynamic>> acceptOrder(AcceptOrderParam param) {
    final result = requestAcceptOrderDataSource.acceptOrder(param);
    return result;
  }
}
