
import 'package:test_flutter_build/src/data/datasource/remote/params/complete_order_param.dart';
import 'package:test_flutter_build/src/data/repository/complete_order/complete_order_repository.dart';
import 'package:test_flutter_build/src/domain/usecase/base_use_case.dart';

class RequestCompleteOrderUserCase extends BaseUseCase<Map<String, dynamic>, CompleteOrderParam> {
  final CompleteOrderRepository repository;
  RequestCompleteOrderUserCase({required this.repository});

  @override
  Future<Map<String, dynamic>> invoke({required CompleteOrderParam param}) async {
    final result = await repository.completeOrder(param: param);
    return result;
  }
}