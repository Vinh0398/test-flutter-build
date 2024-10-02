class ReturnPackageOrderParam {
  String orderId;
  double lat;
  double lng;
  String? porInfo;

  ReturnPackageOrderParam({
    required this.lng,
    required this.lat,
    required this.orderId,
    this.porInfo,
  });
}
