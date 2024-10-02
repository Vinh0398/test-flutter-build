import 'dart:convert';
import 'package:firebase_remote_config/firebase_remote_config.dart';

import 'layout_sections_config.dart';

final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

class RemoteConfigUtils {

  RemoteConfigUtils._();

  static initConfig() async {
    await remoteConfig.setConfigSettings(
        RemoteConfigSettings(fetchTimeout: const Duration(seconds: 10), minimumFetchInterval: Duration.zero)
    );
    await remoteConfig.fetchAndActivate();
  }

  static LayoutModel getLayoutSections() {
    final env = "prod";
    final rawData = remoteConfig.getAll()['config_layout_section_$env'];
    final json = jsonDecode(rawData?.asString() ?? '');
    final config = LayoutModel.fromJson(json);
    return config;
  }
}

