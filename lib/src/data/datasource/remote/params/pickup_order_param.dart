class PickupOrderParam {
  String orderId;
  double lat;
  double lng;
  String? popInfo;

  PickupOrderParam({
    required this.orderId,
    required this.lat,
    required this.lng,
    this.popInfo
  });
}