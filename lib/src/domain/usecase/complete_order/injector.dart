import 'package:test_flutter_build/src/domain/usecase/complete_order/request_complete_order_use_case.dart';
import 'package:provider/provider.dart';

final requestCompleteOrderUseCaseProvider = [
  Provider<RequestCompleteOrderUserCase>(create: (context) =>
      RequestCompleteOrderUserCase(repository: context.read(),),),
];