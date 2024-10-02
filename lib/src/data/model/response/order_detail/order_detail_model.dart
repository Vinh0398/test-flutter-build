import 'package:json_annotation/json_annotation.dart';
import 'package:test_flutter_build/src/data/model/response/request/request_model.dart';
import 'package:test_flutter_build/src/data/model/response/route_path_model.dart';
import 'package:test_flutter_build/src/data/model/response/service/service_model.dart';

part 'order_detail_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OrderDetailModel {
  @JsonKey(name: "_id")
  String id;
  String status;
  String serviceId;
  String? orderType;
  int? supplierStopPointPrice;
  int? supplierSubtotalPrice;
  int? supplierDistancePrice;
  int? supplierTotalPrice;
  int? supplierSpecialRequestPrice;
  int? collectCashForAha;
  int? liability;
  int? commissionFee;
  int? payByCash;
  int? payByBalance;
  String? cityId;
  ServiceModel service;
  num distance;
  List<RoutePathModel> path;
  List<RequestModel> requests;
  String? userName;
  int? ratingBySupplier;
  String? userFacebookId;
  String? polylines;
  String? codPaymentMethod;
  int? userRating;

  OrderDetailModel({
    required this.id,
    required this.status,
    this.cityId,
    required this.service,
    required this.serviceId,
    required this.orderType,
    required this.supplierStopPointPrice,
    required this.supplierSubtotalPrice,
    required this.supplierDistancePrice,
    required this.supplierTotalPrice,
    required this.supplierSpecialRequestPrice,
    required this.collectCashForAha,
    required this.liability,
    required this.commissionFee,
    required this.payByCash,
    required this.payByBalance,
    required this.distance,
    required this.path,
    required this.requests,
    this.userName,
    this.ratingBySupplier,
    this.userFacebookId,
    required this.polylines,
    this.codPaymentMethod,
    this.userRating,
  });

  bool get isRentOrder {
    return orderType == "rent" ||
        serviceId.contains("rent") ||
        (service.isRentService ?? false);
  }

  bool get isRideOrder {
    return orderType == "ride-hailing" ||
        serviceId.contains("RIDE") ||
        (service.isRideService ?? false);
  }

  bool get isCompleted {
    return status == OrderStatus.completed.value;
  }

  bool get isAssigning {
    return status == OrderStatus.assigning.value;
  }

  bool get isAccepted {
    return status == OrderStatus.accepted.value;
  }

  bool get isInProcess {
    return status == OrderStatus.processing.value;
  }

  bool get isCancelled {
    return status == OrderStatus.cancel.value;
  }

  bool get isFail {
    return status == OrderStatus.fail.value;
  }

  bool get isCompletedAllPath {
    return path.every((path) => path.status == OrderStatus.completed.value);
  }

  int numberOfPath() {
    return path.length;
  }

  RoutePathModel getRoutePath(int index) {
    return path[index];
  }

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDetailModelToJson(this);
}

enum OrderStatus {
  assigning("ASSIGNING"),
  accepted("ACCEPTED"),
  processing("IN PROCESS"),
  completed("COMPLETED"),
  cancel("CANCEL"),
  fail("FAIL"),
  ide("IDLE"),
  ;

  final String value;

  const OrderStatus(this.value);

  static OrderStatus of(String value) {
    final status = OrderStatus.values
        .firstWhere((element) => element.value.toUpperCase() == value);
    return status;
  }

  String getLocalizedStatus() {
    switch (this) {
      case OrderStatus.completed:
        return "Đã hoàn thành";
      case OrderStatus.accepted:
        return "Đã nhận";
      case OrderStatus.assigning:
        return "Đang tìm";
      case OrderStatus.cancel:
        return "Đã hủy";
      case OrderStatus.processing:
        return "Đang thực hiện";
      default:
        return "";
    }
  }
}
