import 'package:test_flutter_build/src/domain/usecase/fail_order/request_fail_order_use_case.dart';
import 'package:provider/provider.dart';

final requestFailOrderUseCaseProvider = [
  Provider<RequestFailOrderUseCase>(create: (context) =>
      RequestFailOrderUseCase(failOrderRepository: context.read(),),),
];