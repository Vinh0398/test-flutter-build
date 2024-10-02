import 'package:test_flutter_build/src/domain/usecase/base_use_case.dart';

import '../../../data/datasource/remote/params/pickup_order_param.dart';
import '../../../data/repository/pickup_order/pickup_order_repository.dart';

class PickupOrderUseCase extends BaseUseCase<Map<String, dynamic>, PickupOrderParam> {
  PickupOrderRepository pickupOrderRepository;
  PickupOrderUseCase({required this.pickupOrderRepository});
  @override
  Future<Map<String, dynamic>> invoke({required PickupOrderParam param}) async {
    final result = await pickupOrderRepository.pickupOrder(param);
    return result;
  }
}