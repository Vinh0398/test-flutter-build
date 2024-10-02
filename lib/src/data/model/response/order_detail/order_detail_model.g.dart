// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetailModel _$OrderDetailModelFromJson(Map<String, dynamic> json) =>
    OrderDetailModel(
      id: json['_id'] as String,
      status: json['status'] as String,
      cityId: json['city_id'] as String?,
      service: ServiceModel.fromJson(json['service'] as Map<String, dynamic>),
      serviceId: json['service_id'] as String,
      orderType: json['order_type'] as String?,
      supplierStopPointPrice:
          (json['supplier_stop_point_price'] as num?)?.toInt(),
      supplierSubtotalPrice: json['supplier_subtotal_price'] == null ? 0 : (json['supplier_subtotal_price'] as num?)?.toInt(),
      supplierDistancePrice: json['supplier_distance_price'] == null ? 0 : (json['supplier_distance_price'] as num?)?.toInt(),
      supplierTotalPrice: json['supplier_total_price'] == null ? 0 : (json['supplier_total_price'] as num?)?.toInt(),
      supplierSpecialRequestPrice:
      json['supplier_special_request_price'] == null ? 0 : (json['supplier_special_request_price'] as num?)?.toInt(),
      collectCashForAha: json['collect_cash_for_aha'] == null ? 0 : (json['collect_cash_for_aha'] as num?)?.toInt(),
      liability: json['liability'] == null ? 0 : (json['liability'] as num?)?.toInt(),
      commissionFee: json['commission_fee'] == null ? 0 : (json['commission_fee'] as num?)?.toInt(),
      payByCash: json['pay_by_cash'] == null ? 0 : (json['pay_by_cash'] as num?)?.toInt(),
      payByBalance: json['pay_by_balance'] == null ? 0 : (json['pay_by_balance'] as num?)?.toInt(),
      distance: json['distance'] as num,
      path: (json['path'] as List<dynamic>)
          .map((e) => RoutePathModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      requests: (json['requests'] as List<dynamic>)
          .map((e) => RequestModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      userName: json['user_name'] as String?,
      ratingBySupplier: json['rating_by_supplier'] == null ? 0 : (json['rating_by_supplier'] as num?)?.toInt(),
      userFacebookId: json['user_facebook_id'] as String?,
      polylines: json['polylines'] as String?,
      codPaymentMethod: json['cod_payment_method'] as String?,
      userRating: json['user_rating'] == null ? 0 : (json['user_rating'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OrderDetailModelToJson(OrderDetailModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'status': instance.status,
      'service_id': instance.serviceId,
      'order_type': instance.orderType,
      'supplier_stop_point_price': instance.supplierStopPointPrice,
      'supplier_subtotal_price': instance.supplierSubtotalPrice,
      'supplier_distance_price': instance.supplierDistancePrice,
      'supplier_total_price': instance.supplierTotalPrice,
      'supplier_special_request_price': instance.supplierSpecialRequestPrice,
      'collect_cash_for_aha': instance.collectCashForAha,
      'liability': instance.liability,
      'commission_fee': instance.commissionFee,
      'pay_by_cash': instance.payByCash,
      'pay_by_balance': instance.payByBalance,
      'city_id': instance.cityId,
      'service': instance.service,
      'distance': instance.distance,
      'path': instance.path,
      'requests': instance.requests,
      'user_name': instance.userName,
      'rating_by_supplier': instance.ratingBySupplier,
      'user_facebook_id': instance.userFacebookId,
      'polylines': instance.polylines,
      'cod_payment_method': instance.codPaymentMethod,
      'user_rating': instance.userRating,
    };
