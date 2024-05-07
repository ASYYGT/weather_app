class CloudsModel {
  dynamic all;
  CloudsModel({this.all});
  factory CloudsModel.fromJson(Map<String, dynamic> json) {
    return CloudsModel(
      all: json["all"],
    );
  }
  Map<String, dynamic> toJson() => {
        "all": all,
      };
}
