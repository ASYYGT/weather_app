class SysModel {
  dynamic type;
  dynamic id;
  dynamic country;
  dynamic sunrise;
  dynamic sunset;
  SysModel({
    this.type,
    this.id,
    this.country,
    this.sunrise,
    this.sunset,
  });
  factory SysModel.fromJson(Map<String, dynamic> json) {
    return SysModel(
      type: json["type"],
      id: json["id"],
      country: json["country"],
      sunrise: json["sunrise"],
      sunset: json["sunset"],
    );
  }
  Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
        "country": country,
        "sunrise": sunrise,
        "sunset": sunset,
      };
}
