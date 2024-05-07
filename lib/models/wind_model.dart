class WindModel {
  dynamic speed;
  dynamic deg;
  dynamic gust;
  WindModel({
    this.speed,
    this.deg,
    this.gust,
  });
  factory WindModel.fromJson(Map<String, dynamic> json) {
    return WindModel(
      speed: json["speed"],
      deg: json["deg"],
      gust: json["gust"],
    );
  }
  Map<String, dynamic> toJson() => {
        "speed": speed,
        "deg": deg,
        "gust": gust,
      };
}
