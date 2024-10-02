class FailOrderParam {
  String orderId;
  double lat;
  double lng;
  String? imageUrl;
  String? comment;
  String? pofInfo;
  String? redeliveryNote;

  FailOrderParam({
    required this.orderId,
    required this.lat,
    required this.lng,
    this.imageUrl,
    this.comment,
    this.pofInfo,
    this.redeliveryNote,
  });
}
