import 'package:provider/provider.dart';
import 'package:test_flutter_build/src/data/datasource/api_service.dart';
import 'package:test_flutter_build/src/data/datasource/remote/fail_order/request_fail_order_data_source.dart';
import 'package:test_flutter_build/src/data/repository/fail_order/fail_order_repository.dart';

final failOrderRepositoryProvider = [
  Provider<ApiService>(
    create: (context) => ApiService(
      context.read(),
    ),
  ),
  Provider<RequestFailOrderDataSource>(
    create: (context) => RequestFailOrderDataSource(
      apiService: context.read(),
    ),
  ),
  Provider<FailOrderRepository>(
    create: (context) => FailOrderRepository(
      requestFailOrderDataSource: context.read(),
    ),
  ),
];
