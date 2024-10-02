class CancelOrderParams {
  final String orderId;
  final String? comment;
  final String? imageUrl;
  final String? pocType;
  final String? pocInfo;

  CancelOrderParams({
    required this.orderId,
    this.comment,
    this.imageUrl,
    this.pocType,
    this.pocInfo,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      'order_id': orderId,
      // 'token': token,
    };
    if (comment != null) data['comment'] = comment;
    if (imageUrl != null) data['image_url'] = imageUrl;
    if (pocType != null) data['poc_type'] = pocType;
    if (pocInfo != null) data['poc_info'] = pocInfo;
    return data;
  }

  factory CancelOrderParams.create({
    required String orderId,
    required String token,
    String? comment,
    String? imageUrl,
    String? pocType,
    String? pocInfo,
  }) {
    return CancelOrderParams(
      orderId: orderId,
      comment: comment,
      imageUrl: imageUrl,
      pocType: pocType,
      pocInfo: pocInfo,
    );
  }
}
