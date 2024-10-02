import 'dart:io';

class Config {
  String token;

  Config({required this.token});

  factory Config.create(Map<String, dynamic> config) {
    return Config(token: config['token']);
  }
}