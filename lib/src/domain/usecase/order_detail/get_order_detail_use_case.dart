import 'package:test_flutter_build/src/data/model/response/order_detail/order_detail_model.dart';
import 'package:test_flutter_build/src/data/repository/oder_detail/order_detail_repository.dart';
import 'package:test_flutter_build/src/domain/usecase/base_use_case.dart';

class GetOrderDetailUseCase extends BaseUseCase<OrderDetailModel, String> {
  final OrderDetailRepository repository;
  GetOrderDetailUseCase({required this.repository});

  @override
  Future<OrderDetailModel> invoke({required String param}) async {
    final result = await repository.getOrderDetail(param);
    return result;
  }

}