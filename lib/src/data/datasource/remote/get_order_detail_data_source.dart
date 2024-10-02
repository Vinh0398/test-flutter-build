import 'package:test_flutter_build/src/core/constant.dart';
import 'package:test_flutter_build/src/data/datasource/api_service.dart';
import 'package:test_flutter_build/src/data/datasource/remote/params/cancel_order_param.dart';
import 'package:test_flutter_build/src/data/datasource/remote/params/proof_of_work_param.dart';
import 'package:test_flutter_build/src/data/model/entity/app_config_entity/app_config_model.dart';
import 'package:test_flutter_build/src/data/model/response/order_detail/order_detail_model.dart';
import 'package:test_flutter_build/src/data/model/response/proof_of_work/proof_of_work.dart';
import 'package:test_flutter_build/src/data/repository/oder_detail/order_detail_repository.dart';
import 'package:test_flutter_build/src/utils/app_config_service.dart';
import 'package:test_flutter_build/src/utils/get_it_utils.dart';
import 'package:test_flutter_build/src/utils/platform_channel.dart';

class GetOrderDetailDataSource extends OrderDetailDataSource {
  final ApiService apiService;

  GetOrderDetailDataSource({required this.apiService});

  final appConfig = GetItUtil().sl.get<AppConfigService>().getAppConfig();
  // final token = appConfig.token;
  @override
  Future<OrderDetailModel> getOrderDetail(String orderID) async {
    // final config = await PlatFormChannel.getConfig();
    final token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0eXAiOiJzdXBwbGllciIsImNpZCI6Ijg0OTQxODYwNjQ5Iiwic3RhdHVzIjoiQlVTWSIsImVvYyI6InZpbmhuZDFAYWhhbW92ZS5jb20iLCJub2MiOiJOZ3V5ZW4gVmluaCIsImN0eSI6IlNHTiIsImFwcCI6Ik9uV2hlZWwiLCJpbWVpIjoiMjk4M0U2QTEtMzE2Mi00MjQ1LUExQjYtM0ZERDI0NDZDOTdFIiwidHlwZSI6ImlvcyIsInBhcnRuZXIiOiJvbndoZWVsIiwicm9sZSI6ImFkbWluIiwiZXhwIjoxNzI3NTkyMjkwLCJpYXQiOjE3MjczMzMwOTAsImlzcyI6IkFoYU1vdmUifQ.BQQ0lBwtd4D4e6t1A29ZffgLgH9vwJhPds2NxLH9H9c";
    print("--------> check token $token");
    var header = "Bearer $token";
    final result = await apiService.getOrderDetail(orderID, header);
    return result;
  }

  @override
  Future<List<ProofOfWorkModel>> getProofOfWork(ProofOfWorkParams param) async {
    // final config = await PlatFormChannel.getConfig();
    final token = appConfig.token;
    var header = "Bearer $token";
    final result = await apiService.getProofOfWork(param.reasonType.value, param.userType, param.appType, param.serviceId, param.groupStar, header);
    return result;
  }

  @override
  Future<void> cancelOrder(CancelOrderParams param) async {
    // final config = await PlatFormChannel.getConfig();
    final token = appConfig.token;
    var header = "Bearer $token";
    final result = await apiService.cancelOrder(
      param.orderId,
      param.comment,
      param.imageUrl,
      param.pocType,
      param.pocInfo,
      header,
    );
    return result;
  }
}
