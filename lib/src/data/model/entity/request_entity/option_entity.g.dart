// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OptionEntity _$OptionEntityFromJson(Map<String, dynamic> json) => OptionEntity(
      code: json['code'] as String?,
      nameVi: json['name_vi'] as String?,
      nameEn: json['name_en'] as String?,
      price: json['price'] as num?,
      descriptionViVn: json['description_vi_vn'] as String?,
      descriptionEnUs: json['description_en_us'] as String?,
      priceDescriptionViVn: json['price_description_vi_vn'] as String?,
      priceDescriptionEnUs: json['price_description_en_us'] as String?,
      imgUrl: json['img_url'] as String?,
      selectable: json['selectable'] as bool,
      warningMessage: json['warning_message'] as String?,
    );

Map<String, dynamic> _$OptionEntityToJson(OptionEntity instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name_vi': instance.nameVi,
      'name_en': instance.nameEn,
      'price': instance.price,
      'description_vi_vn': instance.descriptionViVn,
      'description_en_us': instance.descriptionEnUs,
      'price_description_vi_vn': instance.priceDescriptionViVn,
      'price_description_en_us': instance.priceDescriptionEnUs,
      'img_url': instance.imgUrl,
      'selectable': instance.selectable,
      'warning_message': instance.warningMessage,
    };
