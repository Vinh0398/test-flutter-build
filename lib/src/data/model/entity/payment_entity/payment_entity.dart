import 'package:json_annotation/json_annotation.dart';

part 'payment_entity.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PaymentEntity {
  String? sId;
  String? nameViVn;
  String? nameEnUs;
  String? code;
  bool? isDefault;
  int? index;
  List<String>? types;
  String? descriptionViVn;
  String? descriptionEnUs;
  String? promoDescriptionViVn;
  String? promoDescriptionEnUs;
  String? promoLink;
  String? iconUrl;
  bool? enable;
  List<String>? disabledForServices;
  String? cType;
  String? deeplink;
  String? methodId;
  String? methodType;
  String? groupType;
  bool? isSupportTokenize;
  bool? isPublic;
  int? payoutFee;
  String? payoutFeeType;
  int? version;
  String? buttonColor;

  PaymentEntity({
    this.sId,
    this.nameViVn,
    this.nameEnUs,
    this.code,
    this.isDefault,
    this.index,
    this.types,
    this.descriptionViVn,
    this.descriptionEnUs,
    this.promoDescriptionViVn,
    this.promoDescriptionEnUs,
    this.promoLink,
    this.iconUrl,
    this.enable,
    this.disabledForServices,
    this.cType,
    this.deeplink,
    this.methodId,
    this.methodType,
    this.groupType,
    this.isSupportTokenize,
    this.isPublic,
    this.payoutFee,
    this.payoutFeeType,
    this.version,
    this.buttonColor,
  });

  factory PaymentEntity.fromJson(Map<String, dynamic> json) =>
      _$PaymentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentEntityToJson(this);
}
