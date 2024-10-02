import 'package:test_flutter_build/src/data/datasource/remote/params/accept_order_param.dart';
import 'package:test_flutter_build/src/data/repository/accept_order/accept_order_repository.dart';
import 'package:test_flutter_build/src/domain/usecase/base_use_case.dart';

class AcceptOrderUseCase extends BaseUseCase<Map<String, dynamic>, AcceptOrderParam> {
  AcceptOrderRepository acceptOrderRepository;
  AcceptOrderUseCase({required this.acceptOrderRepository});
  @override
  Future<Map<String, dynamic>> invoke({required AcceptOrderParam param}) {
    final result = acceptOrderRepository.acceptOrder(param);
    return result;
  }
}