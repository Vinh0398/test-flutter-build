import 'package:test_flutter_build/src/core/constant.dart';
import 'package:test_flutter_build/src/data/datasource/api_service.dart';
import 'package:test_flutter_build/src/data/model/response/payment/payment_model.dart';
import 'package:test_flutter_build/src/data/repository/payment/payment_repository.dart';
import 'package:test_flutter_build/src/utils/app_config_service.dart';
import 'package:test_flutter_build/src/utils/get_it_utils.dart';

class GetPaymentDataSource extends PaymentDataSource {
  final ApiService apiService;

  GetPaymentDataSource({required this.apiService});
  final appConfig = GetItUtil().sl.get<AppConfigService>().getAppConfig();
  @override
  Future<PaymentModel> getPaymentList({required String provider}) async {
    final result = await apiService.getPaymentList(provider,appConfig.token ?? "");
    return result;
  }

}