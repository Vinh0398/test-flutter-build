import 'package:provider/provider.dart';
import 'package:test_flutter_build/src/data/datasource/api_service.dart';
import 'package:test_flutter_build/src/data/datasource/remote/pickup_order/pickup_order_data_source.dart';
import 'package:test_flutter_build/src/data/repository/pickup_order/pickup_order_repository.dart';

final pickupOrderRepositoryProvider = [
  Provider<ApiService>(
    create: (context) => ApiService(
      context.read(),
    ),
  ),
  Provider<RequestPickupOrderDataSource>(
    create: (context) => RequestPickupOrderDataSource(
      apiService: context.read(),
    ),
  ),
  Provider<PickupOrderRepository>(
    create: (context) => PickupOrderRepository(
      requestPickupOrderDataSource: context.read(),
    ),
  ),
];
