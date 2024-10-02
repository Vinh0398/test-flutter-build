class LayoutModel {
  List<ScreenModel> screens;

  LayoutModel({required this.screens});

  factory LayoutModel.fromJson(Map<String, dynamic> json) => LayoutModel(
    screens: List<ScreenModel>.from(
      json["screens"].map((x) => ScreenModel.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "screens": List<dynamic>.from(screens.map((x) => x.toJson())),
  };
}

class ScreenModel {
  String id;
  List<SectionModel> layout;

  ScreenModel({required this.id, required this.layout});

  factory ScreenModel.fromJson(Map<String, dynamic> json) => ScreenModel(
    id: json["id"],
    layout: List<SectionModel>.from(
      json["layout"].map((x) => SectionModel.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "layout": List<dynamic>.from(layout.map((x) => x.toJson())),
  };
}

class SectionModel {
  String type;
  List<String> sectionIds;

  SectionModel({required this.type, required this.sectionIds});

  factory SectionModel.fromJson(Map<String, dynamic> json) => SectionModel(
    type: json["type"],
    sectionIds: List<String>.from(json["section_ids"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "section_ids": List<dynamic>.from(sectionIds),
  };
}