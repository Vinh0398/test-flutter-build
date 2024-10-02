// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestModel _$RequestModelFromJson(Map<String, dynamic> json) => RequestModel(
      enable: json['enable'] as bool,
      isEnableDefault: json['is_enable_default'] as bool,
      nameDefault: json['name_default'] as String?,
      nameViVn: json['name_vi_vn'] as String?,
      nameEnUs: json['name_en_us'] as String?,
      iconUrl: json['icon_url'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      id: json['_id'] as String?,
      serviceId: json['service_id'] as String?,
      type: json['type'] as String?,
      order: (json['order'] as num?)?.toInt(),
      maxInput: (json['max_input'] as num?)?.toInt(),
      minInput: (json['min_input'] as num?)?.toInt(),
      deliveryOption: json['delivery_option'] as bool,
      descriptionUrl: json['description_url'] as String?,
      supplierDescription: json['supplier_description'] as String?,
      imgUrl: json['img_url'] as String?,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => OptionEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      itemPrice: (json['item_price'] as num?)?.toDouble(),
      moneySupport: (json['money_support'] as num?)?.toDouble(),
      numberOfRequest: (json['number_of_request'] as num?)?.toInt(),
      optionCode: json['option_code'] as String?,
      optionDetail: json['option_detail'] as String?,
      originalPrice: (json['original_price'] as num?)?.toDouble(),
      pathIndex: (json['path_index'] as num?)?.toInt(),
      supplierDescriptionEnUs: json['supplier_description_en_us'] as String?,
      supplierDescriptionUrl: json['supplier_description_url'] as String?,
      supplierDescriptionViVn: json['supplier_description_vi_vn'] as String?,
      tierCode: json['tier_code'] as String?,
      tierList: (json['tier_list'] as List<dynamic>?)
          ?.map((e) => TierEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RequestModelToJson(RequestModel instance) =>
    <String, dynamic>{
      'enable': instance.enable,
      'is_enable_default': instance.isEnableDefault,
      'name_default': instance.nameDefault,
      'name_vi_vn': instance.nameViVn,
      'name_en_us': instance.nameEnUs,
      'icon_url': instance.iconUrl,
      'price': instance.price,
      'service_id': instance.serviceId,
      '_id': instance.id,
      'type': instance.type,
      'order': instance.order,
      'max_input': instance.maxInput,
      'min_input': instance.minInput,
      'delivery_option': instance.deliveryOption,
      'description_url': instance.descriptionUrl,
      'supplier_description_vi_vn': instance.supplierDescriptionViVn,
      'supplier_description_en_us': instance.supplierDescriptionEnUs,
      'supplier_description': instance.supplierDescription,
      'supplier_description_url': instance.supplierDescriptionUrl,
      'img_url': instance.imgUrl,
      'item_price': instance.itemPrice,
      'original_price': instance.originalPrice,
      'number_of_request': instance.numberOfRequest,
      'money_support': instance.moneySupport,
      'path_index': instance.pathIndex,
      'tier_list': instance.tierList,
      'options': instance.options,
      'tier_code': instance.tierCode,
      'option_code': instance.optionCode,
      'option_detail': instance.optionDetail,
    };
