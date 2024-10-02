import 'package:test_flutter_build/src/core/constant.dart';
import 'package:test_flutter_build/src/data/datasource/api_service.dart';
import 'package:test_flutter_build/src/data/datasource/remote/params/accept_order_param.dart';
import 'package:test_flutter_build/src/data/repository/accept_order/accept_order_repository.dart';
import 'package:test_flutter_build/src/utils/app_config_service.dart';
import 'package:test_flutter_build/src/utils/get_it_utils.dart';

class RequestAcceptOrderDataSource extends AcceptOrderDataSource {
  final ApiService apiService;

  RequestAcceptOrderDataSource({required this.apiService});

  final appConfig = GetItUtil().sl.get<AppConfigService>().getAppConfig();
  @override
  Future<Map<String, dynamic>> acceptOrder(AcceptOrderParam param) async {
    final response = await apiService.acceptOrder(
      appConfig.token ?? "",
      param.orderId,
      param.lat,
      param.lng,
      param.popInfo,
    );
    Map<String, dynamic> result = {};

    if (response.response.statusCode == 200) {
      result["success"] = true;
    } else {
      result["success"] = false;
      result["status_code"] = response.response.statusCode;
    }
    return result;
  }
}
