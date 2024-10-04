class RoutePathModel {
  String address;
  num lat;
  num lng;
  num? cod;
  String status;
  num supplierCod;

  RoutePathModel({
    required this.address,
    required this.lat,
    required this.lng,
    this.cod,
    required this.status,
    required this.supplierCod,
  });

  factory RoutePathModel.fromJson(Map<String, dynamic> json) => RoutePathModel(
      address: json["address"],
      lat: json["lat"] ?? 0,
      lng: json["lng"] ?? 0,
      cod: json["cod"] ?? 0,
      status: json["status"] ?? "",
      supplierCod: json["supplier_cod"] ?? 0,);

  Map<String, dynamic> toJson() => {
    "address": address,
    "lat": lat,
    "lng": lng,
    "cod": cod,
    "status": status,
    "supplier_cod": supplierCod
  };
}
