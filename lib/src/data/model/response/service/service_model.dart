import 'dart:core';

class ServiceModel {
  String id;
  String? nameDefault;
  String? nameEnUs;
  String? nameViVn;
  bool enable;
  bool partner;
  num? order;
  String? cityId;
  String? iconUrl;
  String? mapIconUrl;
  String? parentId;
  String? commissionType;
  num? commissionValue;
  String? distanceFee;

  num? broadcastDistance;
  num? advanceBroadcastDistance;
  bool requireTo;
  bool requireRequest;
  num? stopFee;
  num? stopFailed;
  num? maxStopPoints;
  bool autoAssign;
  num? autoAssignDistance;
  List<String>? autoAssignDistricts;
  num? timeout;
  num? acceptInterval;
  num? completeInterval;
  String? openingHours;
  num? cod;
  num? firstOrderCod;
  num? poolTimeout;
  num? poolTimeoutCommissionValue;
  String? acceptMessage;
  num? maxConcurrentOrders;
  String? deliveryType;

  ServiceModel({
    required this.id,
    this.order,
    this.iconUrl,
    this.nameEnUs,
    this.nameViVn,
    this.nameDefault,
    required this.enable,
    this.acceptInterval,
    this.acceptMessage,
    this.advanceBroadcastDistance,
    required this.autoAssign,
    this.autoAssignDistance,
    this.autoAssignDistricts,
    this.broadcastDistance,
    this.cityId,
    this.cod,
    this.commissionType,
    this.commissionValue,
    this.completeInterval,
    this.distanceFee,
    this.firstOrderCod,
    this.mapIconUrl,
    this.maxConcurrentOrders,
    this.maxStopPoints,
    this.openingHours,
    this.parentId,
    required this.partner,
    this.poolTimeout,
    this.poolTimeoutCommissionValue,
    required this.requireRequest,
    required this.requireTo,
    this.stopFailed,
    this.stopFee,
    this.timeout,
    this.deliveryType,
  });

  bool? get isRentService {
    return deliveryType == "RENTAL";
  }

  bool? get isRideService {
    return deliveryType == "RIDE";
  }

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
      id: json["_id"],
      enable: json["enable"] ?? false,
      autoAssign: json["auto_assign"] ?? false,
      partner: json["partner"] ?? false,
      requireRequest: json["require_request"] ?? false,
      requireTo: json["require_to"] ?? false,
      nameDefault: json["name_default"] ?? "",
      nameEnUs: json["name_en_us"],
      nameViVn: json["name_vi_vn"],
      iconUrl: json["icon_url"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "enable": enable,
        "auto_assign": autoAssign,
        "partner": partner,
        "require_request": requireRequest,
        "require_to": requireTo,
        "name_default": nameDefault,
        "name_en_us": nameEnUs,
        "name_vi_vn": nameViVn,
        "icon_url": iconUrl,
      };
}
