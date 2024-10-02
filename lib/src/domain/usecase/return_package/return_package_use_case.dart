import 'package:test_flutter_build/src/data/datasource/remote/params/return_package_order_param.dart';
import 'package:test_flutter_build/src/data/repository/return_package/return_package_repository.dart';
import 'package:test_flutter_build/src/domain/usecase/base_use_case.dart';

class ReturnPackageUseCase extends BaseUseCase<Map<String, dynamic>, ReturnPackageOrderParam> {
  ReturnPackageRepository repository;

  ReturnPackageUseCase(this.repository);

  @override
  Future<Map<String, dynamic>> invoke({required ReturnPackageOrderParam param}) async {
    final result = await repository.requestReturnPackage(param);
    return result;
  }

}