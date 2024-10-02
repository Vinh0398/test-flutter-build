class ProofOfWorkModel {
  final String? id;
  final String? reasonType;
  final String? titleVi;
  final String? titleEn;
  final String? descriptionVi;
  final String? groupOfReasons;
  final String? groupVi;
  final List<String>? requires;

  ProofOfWorkModel({
    this.id,
    this.reasonType,
    this.titleVi,
    this.titleEn,
    this.descriptionVi,
    this.groupOfReasons,
    this.groupVi,
    this.requires,
  });

  factory ProofOfWorkModel.fromJson(Map<String, dynamic> json) {
    return ProofOfWorkModel(
      id: json['_id'],
      reasonType: json['reason_type'],
      titleVi: json['title_vi'],
      titleEn: json['title_en'],
      descriptionVi: json['description_vi'],
      groupOfReasons: json['group_of_reasons'],
      groupVi: json['group_vi'],
      requires: List<String>.from(json['requires'] ?? []),
    );
  }
}
