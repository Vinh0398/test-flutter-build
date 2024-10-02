import 'package:test_flutter_build/src/core/constant.dart';
import 'package:test_flutter_build/src/data/datasource/api_service.dart';
import 'package:test_flutter_build/src/data/datasource/remote/params/fail_order_param.dart';
import 'package:test_flutter_build/src/data/repository/fail_order/fail_order_repository.dart';
import 'package:test_flutter_build/src/utils/app_config_service.dart';
import 'package:test_flutter_build/src/utils/get_it_utils.dart';

class RequestFailOrderDataSource extends FailOrderDataSource {
  final ApiService apiService;

  RequestFailOrderDataSource({required this.apiService});

  final appConfig = GetItUtil().sl.get<AppConfigService>().getAppConfig();

  @override
  Future<Map<String, dynamic>> failOrder(FailOrderParam param) async {
    final response = await apiService.failOrder(
      appConfig.token ?? "",
      param.orderId,
      param.comment,
      param.lat,
      param.lng,
      param.imageUrl,
      param.pofInfo,
      param.redeliveryNote,
    );
    Map<String, dynamic> result = {};

    if (response.response.statusCode == 200) {
      result["success"] = true;
    } else if (response.response.statusCode == 406) {
      result["success"] = false;
      result["status_code"] = response.response.statusCode;
    }
    return result;
  }
}
