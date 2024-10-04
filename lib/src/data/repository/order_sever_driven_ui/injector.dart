import 'package:test_flutter_build/src/data/datasource/api_service.dart';
import 'package:test_flutter_build/src/data/datasource/remote/get_sever_ui_remote_data_source.dart';
import 'package:test_flutter_build/src/data/repository/order_sever_driven_ui/order_sever_driven_ui_repository.dart';
import 'package:provider/provider.dart';
import '../../../domain/usecase/order_sever_driven_ui/order_sever_driven_ui_use_case.dart';

final orderSeverDrivenUIRepositoryProvider = [
  Provider<ApiService>(
    create: (context) => ApiService(
      context.read(),
    ),
  ),
  Provider<GetSeverUIRemoteDataSource>(
    create: (context) => GetSeverUIRemoteDataSource(apiService: context.read()),
  ),
  Provider<OrderSeverDrivenUIRepository>(
    create: (context) => OrderSeverDrivenUIRepository(
      getSeverUIRemoteDataSource: context.read(),
    ),
  ),
];