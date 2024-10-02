import '../../../utils/texts_utils.dart';
import 'order_detail/order_detail_model.dart';

class RoutePathModel {
  String address;
  num lat;
  num lng;
  num? cod;
  String status;
  num supplierCod;
  String trackingNumber;
  List<String> trackingNumbers = [];
  String name;

  RoutePathModel(
      {required this.address,
      required this.lat,
      required this.lng,
      this.cod,
      required this.status,
      required this.supplierCod,
      required this.trackingNumber,
      required this.trackingNumbers,
      required this.name});

  factory RoutePathModel.fromJson(Map<String, dynamic> json) => RoutePathModel(
      address: json["address"],
      lat: json["lat"] ?? 0,
      lng: json["lng"] ?? 0,
      cod: json["cod"] ?? 0,
      status: json["status"] ?? "",
      supplierCod: json["supplier_cod"] ?? 0,
      trackingNumber: json["tracking_number"] ?? "",
      trackingNumbers: List<String>.from(json["tracking_numbers"] ?? []),
      name: json["name"]);

  Map<String, dynamic> toJson() => {
        "address": address,
        "lat": lat,
        "lng": lng,
        "cod": cod,
        "status": status,
        "supplier_cod": supplierCod,
        "tracking_numbers": trackingNumbers,
        "name": name
      };

  List<String>? getTrackingNumbers() {
    final numbers = <String>[];
    for (final number in trackingNumbers) {
      final value = number.trim();
      if (value.isNotEmpty) {
        numbers.add(value);
      }
    }
    return numbers.isEmpty ? null : numbers;
  }

  bool isTrackNumberFound(String searchText) {
    print("searchText: $searchText");
    if (searchText.isEmpty) {
      return false;
    }

    if (TextsUtils.containString(trackingNumber, searchText)) {
      return true;
    }

    final trackingNumbers = getTrackingNumbers();
    for (final _trackingNumber in trackingNumbers ?? []) {
      if (TextsUtils.containString(_trackingNumber, searchText)) {
        return true;
      }
    }

    return false;
  }

  bool get isCompleted {
    return status == OrderStatus.completed.value;
  }

  String getAddress() {
    final stringArray = address.split(', ');
    final name = stringArray[0];
    var restAddress = '';

    for (var i = 1; i < stringArray.length; i++) {
      restAddress = i == 1 ? stringArray[i] : '$restAddress, ${stringArray[i]}';
    }

    print('Rest Address: $restAddress');
    print('Name: $name');
    return '$name: $restAddress';
  }

  factory RoutePathModel.create(Map<String, dynamic> json) {
    return RoutePathModel(
        address: json["address"],
        lat: json["lat"],
        lng: json["lng"],
        status: json["status"],
        supplierCod: json["supplier_cod"],
        trackingNumber: json["tracking_number"],
        trackingNumbers: List<String>.from(json["tracking_numbers"] ?? []),
        name: json["name"]);
  }
}
