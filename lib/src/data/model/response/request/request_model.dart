
import 'package:test_flutter_build/src/data/model/entity/request_entity/option_entity.dart';
import 'package:test_flutter_build/src/data/model/entity/request_entity/tier_entity.dart';

class RequestModel {
  bool enable;
  bool isEnableDefault;
  String? nameDefault;
  String? nameViVn;
  String? nameEnUs;
  String? iconUrl;
  num? price;
  String? serviceId;
  String? id;
  String? type;
  num? order;
  num? maxInput;
  num? minInput;
  bool deliveryOption;
  String? descriptionUrl;
  String? supplierDescriptionViVn;
  String? supplierDescriptionEnUs;
  String? supplierDescription;
  String? supplierDescriptionUrl;
  String? imgUrl;
  num? itemPrice;
  num? originalPrice;
  num? numberOfRequest;
  num? moneySupport;
  num? pathIndex;
  List<TierEntity>? tierList;
  List<OptionEntity>? options;
  String? tierCode;
  String? optionCode;
  String? optionDetail;

  RequestModel({
    required this.enable,
    required this.isEnableDefault,
    this.nameDefault,
    this.nameViVn,
    this.nameEnUs,
    this.iconUrl,
    this.price,
    this.id,
    this.serviceId,
    this.type,
    this.order,
    this.maxInput,
    this.minInput,
    required this.deliveryOption,
    this.descriptionUrl,
    this.supplierDescription,
    this.imgUrl,
    this.options,
    this.itemPrice,
    this.moneySupport,
    this.numberOfRequest,
    this.optionCode,
    this.optionDetail,
    this.originalPrice,
    this.pathIndex,
    this.supplierDescriptionEnUs,
    this.supplierDescriptionUrl,
    this.supplierDescriptionViVn,
    this.tierCode,
    this.tierList,
  });
}
