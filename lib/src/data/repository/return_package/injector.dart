import 'package:test_flutter_build/src/data/datasource/api_service.dart';
import 'package:test_flutter_build/src/data/datasource/remote/return_package/request_return_package_data_source.dart';
import 'package:test_flutter_build/src/data/repository/return_package/return_package_repository.dart';
import 'package:provider/provider.dart';

final returnPackageRepositoryProvider = [
  Provider<ApiService>(
    create: (context) => ApiService(
      context.read(),
    ),
  ),
  Provider<RequestReturnPackageDataSource>(
    create: (context) => RequestReturnPackageDataSource(
      context.read(),
    ),
  ),
  Provider<ReturnPackageRepository>(
    create: (context) => ReturnPackageRepository(
      context.read(),
    ),
  ),
];
