class CoordModel {
  dynamic lon;
  dynamic lat;
  CoordModel({this.lat, this.lon});

  factory CoordModel.fromJson(Map<String, dynamic> json) {
    return CoordModel(lat: json["lat"], lon: json["lon"]);
  }
  Map<String, dynamic> toJson() => {"lat": lat, "lon": lon};
}
