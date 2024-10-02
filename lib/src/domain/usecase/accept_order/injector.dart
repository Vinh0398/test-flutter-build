import 'package:test_flutter_build/src/domain/usecase/accept_order/accept_order_use_case.dart';
import 'package:provider/provider.dart';

final acceptOrderUseCaseProvider = [
  Provider<AcceptOrderUseCase>(create: (context) =>
  AcceptOrderUseCase(acceptOrderRepository: context.read()))
];