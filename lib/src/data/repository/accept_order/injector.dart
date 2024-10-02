import 'package:provider/provider.dart';
import 'package:test_flutter_build/src/data/datasource/api_service.dart';
import 'package:test_flutter_build/src/data/datasource/remote/accept_order/request_accept_order_data_source.dart';
import 'package:test_flutter_build/src/data/repository/accept_order/accept_order_repository.dart';

final acceptOrderRepositoryProvider = [
  Provider<ApiService>(
      create: (context) => ApiService(
            context.read(),
          )),
  Provider<RequestAcceptOrderDataSource>(
      create: (context) =>
          RequestAcceptOrderDataSource(apiService: context.read())),
  Provider<AcceptOrderRepository>(
      create: (context) =>
          AcceptOrderRepository(requestAcceptOrderDataSource: context.read())),
];
