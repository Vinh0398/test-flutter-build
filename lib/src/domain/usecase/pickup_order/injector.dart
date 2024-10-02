import 'package:test_flutter_build/src/domain/usecase/fail_order/request_fail_order_use_case.dart';
import 'package:provider/provider.dart';

import 'pickup_order_use_case.dart';

final requestPickupOrderUseCaseProvider = [
  Provider<PickupOrderUseCase>(create: (context) =>
      PickupOrderUseCase(pickupOrderRepository: context.read(),),),
];