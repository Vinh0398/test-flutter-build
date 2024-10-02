
import 'package:test_flutter_build/src/utils/app_config_service.dart';
import 'package:test_flutter_build/src/utils/platform_channel.dart';
import 'package:get_it/get_it.dart';

class GetItUtil {
  final GetIt sl = GetIt.I;

  Future<void> setupLocators() async {
    final Map<String, dynamic> config = await PlatformChannelMethod.getConfig();
    sl.registerSingleton<AppConfigService>(AppConfigService(config: config));
  }
}