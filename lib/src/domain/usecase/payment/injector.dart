import 'package:test_flutter_build/src/domain/usecase/payment/get_payment_list_use_case.dart';
import 'package:provider/provider.dart';

final getPaymentListUseCaseProvider = [
  Provider<GetPaymentListUseCase>(
    create: (context) => GetPaymentListUseCase(
      repository: context.read(),
    ),
  ),
];
