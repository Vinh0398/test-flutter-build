import 'package:test_flutter_build/src/data/model/response/payment/payment_model.dart';
import 'package:test_flutter_build/src/data/repository/payment/payment_repository.dart';
import 'package:test_flutter_build/src/domain/usecase/base_use_case.dart';

class GetPaymentListUseCase extends BaseUseCase<PaymentModel, String> {
  final PaymentRepository repository;
  GetPaymentListUseCase({required this.repository});

  @override
  Future<PaymentModel> invoke({required String param}) async {
    final result = await repository.getPaymentList(provider: param);
    return result;
  }
}