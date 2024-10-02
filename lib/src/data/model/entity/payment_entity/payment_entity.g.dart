// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentEntity _$PaymentEntityFromJson(Map<String, dynamic> json) =>
    PaymentEntity(
      sId: json['s_id'] as String?,
      nameViVn: json['name_vi_vn'] as String?,
      nameEnUs: json['name_en_us'] as String?,
      code: json['code'] as String?,
      isDefault: json['is_default'] as bool?,
      index: (json['index'] as num?)?.toInt(),
      types:
          (json['types'] as List<dynamic>?)?.map((e) => e as String).toList(),
      descriptionViVn: json['description_vi_vn'] as String?,
      descriptionEnUs: json['description_en_us'] as String?,
      promoDescriptionViVn: json['promo_description_vi_vn'] as String?,
      promoDescriptionEnUs: json['promo_description_en_us'] as String?,
      promoLink: json['promo_link'] as String?,
      iconUrl: json['icon_url'] as String?,
      enable: json['enable'] as bool?,
      disabledForServices: (json['disabled_for_services'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      cType: json['c_type'] as String?,
      deeplink: json['deeplink'] as String?,
      methodId: json['method_id'] as String?,
      methodType: json['method_type'] as String?,
      groupType: json['group_type'] as String?,
      isSupportTokenize: json['is_support_tokenize'] as bool?,
      isPublic: json['is_public'] as bool?,
      payoutFee: (json['payout_fee'] as num?)?.toInt(),
      payoutFeeType: json['payout_fee_type'] as String?,
      version: (json['version'] as num?)?.toInt(),
      buttonColor: json['button_color'] as String?,
    );

Map<String, dynamic> _$PaymentEntityToJson(PaymentEntity instance) =>
    <String, dynamic>{
      's_id': instance.sId,
      'name_vi_vn': instance.nameViVn,
      'name_en_us': instance.nameEnUs,
      'code': instance.code,
      'is_default': instance.isDefault,
      'index': instance.index,
      'types': instance.types,
      'description_vi_vn': instance.descriptionViVn,
      'description_en_us': instance.descriptionEnUs,
      'promo_description_vi_vn': instance.promoDescriptionViVn,
      'promo_description_en_us': instance.promoDescriptionEnUs,
      'promo_link': instance.promoLink,
      'icon_url': instance.iconUrl,
      'enable': instance.enable,
      'disabled_for_services': instance.disabledForServices,
      'c_type': instance.cType,
      'deeplink': instance.deeplink,
      'method_id': instance.methodId,
      'method_type': instance.methodType,
      'group_type': instance.groupType,
      'is_support_tokenize': instance.isSupportTokenize,
      'is_public': instance.isPublic,
      'payout_fee': instance.payoutFee,
      'payout_fee_type': instance.payoutFeeType,
      'version': instance.version,
      'button_color': instance.buttonColor,
    };
