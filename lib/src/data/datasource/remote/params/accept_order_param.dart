class AcceptOrderParam {
  String orderId;
  double lat;
  double lng;
  String? popInfo;

  AcceptOrderParam({
    required this.orderId,
    required this.lat,
    required this.lng,
    this.popInfo
  });
}


