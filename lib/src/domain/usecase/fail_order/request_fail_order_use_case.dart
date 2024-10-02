import 'package:test_flutter_build/src/data/datasource/remote/params/fail_order_param.dart';
import 'package:test_flutter_build/src/data/repository/fail_order/fail_order_repository.dart';
import 'package:test_flutter_build/src/domain/usecase/base_use_case.dart';

class RequestFailOrderUseCase extends BaseUseCase<Map<String, dynamic>, FailOrderParam> {
  FailOrderRepository failOrderRepository;
  RequestFailOrderUseCase({required this.failOrderRepository});
  @override
  Future<Map<String, dynamic>> invoke({required FailOrderParam param}) async {
    final result = await failOrderRepository.failOrder(param);
    return result;
  }

}