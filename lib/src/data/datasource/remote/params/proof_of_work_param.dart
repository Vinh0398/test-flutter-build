enum ReasonType {
  por("por"),
  poc("poc"),
  rating("rating"),
  pof("pof"),
  ;
  final String value;
  const ReasonType(this.value);
}

class ProofOfWorkParams {
  final ReasonType reasonType;
  final String userType;
  final String appType;
  final String? serviceId;
  final int? groupStar;

  ProofOfWorkParams({
    required this.reasonType,
    required this.userType,
    required this.appType,
    this.serviceId,
    this.groupStar,
  });

  factory ProofOfWorkParams.fromJson(Map<String, dynamic> json) {
    return ProofOfWorkParams(
      reasonType: ReasonType.values.firstWhere(
        (e) => e.toString().split('.').last == json['reason_type'],
        orElse: () => throw ArgumentError('Invalid reasonType'),
      ),
      userType: json['user_type'] as String,
      appType: json['app_type'] as String,
      serviceId: json['service_id'] as String?,
      groupStar: json['group_star'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      'reason_type': reasonType.toString().split('.').last,
      'user_type': userType,
      'app_type': appType,
    };
    if (serviceId != null) {
      data['service_id'] = serviceId;
    }
    if (groupStar != null) {
      data['group_star'] = groupStar;
    }
    return data;
  }

  factory ProofOfWorkParams.create({
    required ReasonType reasonType,
    required String userType,
    required String appType,
    String? serviceId,
    int? groupStar,
  }) {
    if ([ReasonType.por, ReasonType.poc, ReasonType.rating, ReasonType.pof].contains(reasonType) && serviceId != null) {
      return ProofOfWorkParams(
        reasonType: reasonType,
        userType: userType,
        appType: appType,
        serviceId: serviceId,
        groupStar: reasonType == ReasonType.rating ? groupStar : null,
      );
    } else {
      throw ArgumentError('Invalid parameters for ProofOfWorkParams');
    }
  }
}
