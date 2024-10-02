class CompleteOrderParam {
  String orderId;
  double lat;
  double lng;
  String? imageUrl;
  String? comment;
  String? podInfo;

  CompleteOrderParam({
    required this.orderId,
    required this.lat,
    required this.lng,
    this.imageUrl,
    this.comment,
    this.podInfo,
  });
}
