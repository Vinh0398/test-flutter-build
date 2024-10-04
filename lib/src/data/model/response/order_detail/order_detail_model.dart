import 'package:test_flutter_build/src/data/model/response/route_path_model.dart';
import 'package:test_flutter_build/src/data/model/response/service/service_model.dart';

class OrderDetailModel {
  String id;
  String status;
  String serviceId;
  String orderType;
  int? supplierStoppointPrice;
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

  OrderDetailModel({
    required this.id,
    required this.status,
    this.cityId,
    required this.service,
    required this.serviceId,
    required this.orderType,
    required this.supplierStoppointPrice,
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

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailModel(
        id: json["_id"],
        status: json["status"] ?? "",
        serviceId: json["service_id"] ?? "",
        orderType: json["order_type"] ?? "",
        supplierSubtotalPrice: json["supplier_subtotal_price"] ?? 0,
        supplierStoppointPrice: json["supplier_stoppoint_price"] ?? 0,
        supplierDistancePrice: json["supplier_distance_price"] ?? 0,
        supplierSpecialRequestPrice: json["supplier_special_request_price"] ?? 0,
        supplierTotalPrice: json["supplier_total_price"] ?? 0,
        collectCashForAha: json["collect_cash_for_aha"] ?? 0,
        liability: json["liability"] ?? 0,
        commissionFee: json["commission_fee"] ?? 0,
        payByCash: json["pay_by_cash"] ?? 0,
        payByBalance: json["pay_by_balance"] ?? 0,
        cityId: json["city_id"],
        service: ServiceModel.fromJson(json["service"]),
        distance: json["distance"] ?? 0,
        path: (json["path"] as List)
            .map((e) => RoutePathModel.fromJson(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "status": status,
        "service_id": serviceId,
        "city_id": cityId,
        "supplier_subtotal_price": supplierSubtotalPrice,
        "supplier_distance_price": supplierDistancePrice,
        "supplier_stoppoint_price": supplierStoppointPrice,
        "supplier_total_price": supplierTotalPrice,
        "supplier_special_request_price": supplierSpecialRequestPrice,
        "collect_cash_for_aha": collectCashForAha,
        "liability": liability,
        "commission_fee": commissionFee,
        "pay_by_cash": payByCash,
        "pay_by_balance": payByBalance,
        "service": service,
        "distance": distance,
        "path": path,
      };
}

enum OrderStatus {
  cancel("CANCELLED"),
  assigning("ASSIGNING"),
  completed("COMPLETED"),
  processing("IN PROCESS"),
  accepted("ACCEPTED"),
  fail("FAILED"),
  confirming("CONFIRMING"),
  paying("PAYING"),
  idle("IDLE"),
  ;
  final String value;
  const OrderStatus(this.value);

  static OrderStatus of(String value) {
    final status = OrderStatus.values.firstWhere((element) => element.value.toUpperCase() == value);
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
        return "Đã hoàn thành";
    }
  }
}