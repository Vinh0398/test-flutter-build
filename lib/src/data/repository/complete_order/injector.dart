import 'package:provider/provider.dart';
import 'package:test_flutter_build/src/data/datasource/api_service.dart';
import 'package:test_flutter_build/src/data/datasource/remote/complete_order/request_complete_order_data_source.dart';
import 'package:test_flutter_build/src/data/repository/complete_order/complete_order_repository.dart';

final completeOrderRepositoryProvider = [
  Provider<ApiService>(
    create: (context) => ApiService(
      context.read(),
    ),
  ),
  Provider<RequestCompleteOrderDataSource>(
    create: (context) => RequestCompleteOrderDataSource(
      apiService: context.read(),
    ),
  ),
  Provider<CompleteOrderRepository>(
    create: (context) => CompleteOrderRepository(
      requestComplete: context.read(),
    ),
  ),
];
