import 'package:test_flutter_build/src/core/constant.dart';
import 'package:test_flutter_build/src/data/datasource/api_service.dart';
import 'package:test_flutter_build/src/utils/app_config_service.dart';
import 'package:test_flutter_build/src/utils/get_it_utils.dart';

import '../../../repository/pickup_order/pickup_order_repository.dart';
import '../params/pickup_order_param.dart';

class RequestPickupOrderDataSource extends PickupOrderDataSource {
  final ApiService apiService;

  RequestPickupOrderDataSource({required this.apiService});

  final appConfig = GetItUtil().sl.get<AppConfigService>().getAppConfig();
  @override
  Future<Map<String, dynamic>> pickupOrder(PickupOrderParam param) async {
    final response = await apiService.pickupOrder(
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
