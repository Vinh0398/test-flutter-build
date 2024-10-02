import 'package:test_flutter_build/src/domain/usecase/order_sever_driven_ui/order_sever_driven_ui_use_case.dart';
import 'package:provider/provider.dart';

import '../../../data/datasource/local/get_sever_ui_data_source.dart';

final orderSeverDrivenUIUseCaseProvider = [
  Provider<GetSeverUIDataSource>(create: (context) => GetSeverUIDataSource()),
  Provider<OrderSeverDrivenUIUseCase>(
      create: (context) =>
          OrderSeverDrivenUIUseCase(getSeverUIDataSource: context.read()))
];
