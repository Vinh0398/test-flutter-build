import 'package:provider/provider.dart';
import 'package:test_flutter_build/src/data/datasource/api_service.dart';
import 'package:test_flutter_build/src/data/datasource/remote/payment/get_payment_data_source.dart';
import 'package:test_flutter_build/src/data/repository/payment/payment_repository.dart';

final paymentRepositoryProvider = [
  Provider<ApiService>(
    create: (context) => ApiService(
      context.read(),
    ),
  ),
  Provider<GetPaymentDataSource>(
    create: (context) => GetPaymentDataSource(
      apiService: context.read(),
    ),
  ),
  Provider<PaymentRepository>(
    create: (context) => PaymentRepository(
      getPaymentDataSource: context.read(),
    ),
  ),
];
