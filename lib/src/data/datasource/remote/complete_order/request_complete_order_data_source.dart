import 'package:test_flutter_build/src/data/datasource/api_service.dart';
import 'package:test_flutter_build/src/data/datasource/remote/params/cancel_order_param.dart';
import 'package:test_flutter_build/src/data/datasource/remote/params/complete_order_param.dart';
import 'package:test_flutter_build/src/data/repository/complete_order/complete_order_repository.dart';
import 'package:test_flutter_build/src/utils/app_config_service.dart';
import 'package:test_flutter_build/src/utils/get_it_utils.dart';

class RequestCompleteOrderDataSource extends CompleteOrderDataSource {
  final ApiService apiService;

  RequestCompleteOrderDataSource({required this.apiService});

  final appConfig = GetItUtil().sl.get<AppConfigService>().getAppConfig();
  // final token =
  //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0eXAiOiJzdXBwbGllciIsImNpZCI6Ijg0OTQxODYwNjQ5Iiwic3RhdHVzIjoiQlVTWSIsImVvYyI6InZpbmhuZDFAYWhhbW92ZS5jb20iLCJub2MiOiJOZ3V5ZW4gVmluaCIsImN0eSI6IlNHTiIsImFwcCI6Ik9uV2hlZWwiLCJpbWVpIjoiMjk4M0U2QTEtMzE2Mi00MjQ1LUExQjYtM0ZERDI0NDZDOTdFIiwidHlwZSI6ImlvcyIsInBhcnRuZXIiOiJvbndoZWVsIiwicm9sZSI6ImFkbWluIiwiZXhwIjoxNzI3NTkyMjkwLCJpYXQiOjE3MjczMzMwOTAsImlzcyI6IkFoYU1vdmUifQ.BQQ0lBwtd4D4e6t1A29ZffgLgH9vwJhPds2NxLH9H9c";

  @override
  Future<Map<String, dynamic>> completeOrder({required CompleteOrderParam param}) async {
    final response = await apiService.completeOrder(
      appConfig.token ?? "",
      param.orderId,
      param.comment,
      param.lat,
      param.lng,
      param.imageUrl,
      param.podInfo,
    );
    if (response.response.statusCode == 200) {
      Map<String, dynamic> result = { "success": true};
      return result;
    } else if (response.response.statusCode == 406) {
      Map<String, dynamic> result = { "success": false, "status_code" : response.response.statusCode};
      return result;
    } else {
      Map<String, dynamic> result = { "success": false};
      return result;
    }
  }
}
