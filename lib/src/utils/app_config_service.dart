import 'package:test_flutter_build/src/data/model/entity/app_config_entity/app_config_model.dart';

class AppConfigService {
  final Map<String, dynamic> config;
  late AppConfigModel appConfig;
  AppConfigService({required this.config});

  AppConfigModel getAppConfig() {
    final _appConfig = AppConfigModel.fromJson(config);
    print("---------> check ${_appConfig.token}");
    appConfig = _appConfig;
    return appConfig;
  }

  AppConfigModel refreshToken({required String token, required String refreshToken}) {
    appConfig.token = token;
    appConfig.refreshToken = refreshToken;
    return appConfig;
  }
}