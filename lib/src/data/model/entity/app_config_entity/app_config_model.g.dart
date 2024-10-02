// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppConfigModel _$AppConfigModelFromJson(Map<String, dynamic> json) =>
    AppConfigModel(
      token: json['token'] as String?,
      refreshToken: json['refresh_token'] as String?,
      acceptEncoding: json['accept_encoding'] as String?,
      acceptLanguage: json['accept_language'] as String?,
      userAgent: json['user_agent'] as String?,
      userId: json['user_id'] as String?,
    );

Map<String, dynamic> _$AppConfigModelToJson(AppConfigModel instance) =>
    <String, dynamic>{
      'token': instance.token,
      'refresh_token': instance.refreshToken,
      'user_agent': instance.userAgent,
      'accept_language': instance.acceptLanguage,
      'accept_encoding': instance.acceptEncoding,
      'user_id': instance.userId,
    };
