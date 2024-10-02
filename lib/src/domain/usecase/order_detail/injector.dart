import 'package:test_flutter_build/src/domain/usecase/order_detail/cancel_order_use_case.dart';
import 'package:test_flutter_build/src/domain/usecase/order_detail/get_order_detail_use_case.dart';
import 'package:test_flutter_build/src/domain/usecase/order_detail/get_proof_of_work_use_case.dart';
import 'package:provider/provider.dart';

final getOrderDetailUseCaseProvider = [
  Provider<GetOrderDetailUseCase>(
    create: (context) => GetOrderDetailUseCase(repository: context.read()),
  ),
  Provider<GetProofOfWorkUseCase>(
    create: (context) => GetProofOfWorkUseCase(orderRepository: context.read()),
  ),
  Provider<CancelOrderUseCase>(
    create: (context) => CancelOrderUseCase(orderRepository: context.read()),
  ),
];
