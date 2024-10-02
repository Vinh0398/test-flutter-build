import 'package:test_flutter_build/src/data/datasource/remote/payment/get_payment_data_source.dart';
import 'package:test_flutter_build/src/data/model/response/payment/payment_model.dart';

abstract class PaymentDataSource {
  Future<PaymentModel> getPaymentList({required String provider});
}

class PaymentRepository extends PaymentDataSource {
  final GetPaymentDataSource getPaymentDataSource;

  PaymentRepository({required this.getPaymentDataSource});
  @override
  Future<PaymentModel> getPaymentList({required String provider}) async {
    final result = await getPaymentDataSource.getPaymentList(provider: provider);
    return result;
  }
}