import 'package:test_flutter_build/src/data/datasource/remote/params/pickup_order_param.dart';

import '../../datasource/remote/pickup_order/pickup_order_data_source.dart';

abstract class PickupOrderDataSource {
  Future<Map<String, dynamic>> pickupOrder(PickupOrderParam param);
}

class PickupOrderRepository extends PickupOrderDataSource {
  RequestPickupOrderDataSource requestPickupOrderDataSource;
  PickupOrderRepository({required this.requestPickupOrderDataSource});
  @override
  Future<Map<String, dynamic>> pickupOrder(PickupOrderParam param) async {
    final result = await requestPickupOrderDataSource.pickupOrder(param);
    return result;
  }
}