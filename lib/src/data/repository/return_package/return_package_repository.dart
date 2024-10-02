import 'package:test_flutter_build/src/data/datasource/remote/params/return_package_order_param.dart';
import 'package:test_flutter_build/src/data/datasource/remote/return_package/request_return_package_data_source.dart';

abstract class ReturnPackageDataSource {
  Future<Map<String, dynamic>> requestReturnPackage(ReturnPackageOrderParam param);
}

class ReturnPackageRepository extends ReturnPackageDataSource {
  RequestReturnPackageDataSource requestReturnPackageDataSource;

  ReturnPackageRepository(this.requestReturnPackageDataSource);
  @override
  Future<Map<String, dynamic>> requestReturnPackage(ReturnPackageOrderParam param) async {
    final result = await requestReturnPackageDataSource.requestReturnPackage(param);
    return result;
  }

}