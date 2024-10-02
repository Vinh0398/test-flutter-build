
import 'package:test_flutter_build/src/data/datasource/remote/params/cancel_order_param.dart';
import 'package:test_flutter_build/src/data/repository/oder_detail/order_detail_repository.dart';
import 'package:test_flutter_build/src/domain/usecase/base_use_case.dart';

class CancelOrderUseCase implements BaseUseCase<void, CancelOrderParams> {
  final OrderDetailRepository orderRepository;

  CancelOrderUseCase({required this.orderRepository});

  @override
  Future<void> invoke({required CancelOrderParams param}) async {
    return await orderRepository.cancelOrder(param);
  }
}
