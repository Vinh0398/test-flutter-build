import 'package:provider/provider.dart';
import 'package:test_flutter_build/src/data/datasource/api_service.dart';
import 'package:test_flutter_build/src/data/datasource/remote/get_order_detail_data_source.dart';
import 'package:test_flutter_build/src/data/repository/oder_detail/order_detail_repository.dart';

final orderDetailRepositoryProvider = [
  Provider<ApiService>(
    create: (context) => ApiService(
      context.read(),
    ),
  ),
  Provider<GetOrderDetailDataSource>(
    create: (context) => GetOrderDetailDataSource(
      apiService: context.read(),
    ),
  ),
  Provider<OrderDetailRepository>(
    create: (context) => OrderDetailRepository(
      orderDetailDataSource: context.read(),
    ),
  ),
];
