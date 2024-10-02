import 'package:json_annotation/json_annotation.dart';

part 'app_config_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AppConfigModel {
  String? token;
  String? refreshToken;
  String? userAgent;
  String? acceptLanguage;
  String? acceptEncoding;
  String? userId;

  AppConfigModel({
    this.token,
    this.refreshToken,
    this.acceptEncoding,
    this.acceptLanguage,
    this.userAgent,
    this.userId,
  });

  factory AppConfigModel.fromJson(Map<String, dynamic> json) =>
      _$AppConfigModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppConfigModelToJson(this);
}
