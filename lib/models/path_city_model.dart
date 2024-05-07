class PathCityModel {
  dynamic name;
  dynamic lon;
  dynamic lat;
  PathCityModel({this.name, this.lon, this.lat});
  factory PathCityModel.fromJson(Map<String, dynamic> json) {
    return PathCityModel(
        name: json["name"], lon: json["lon"], lat: json["lat"]);
  }
  Map<String, dynamic> toJson() => {"name": name, "lon": lon, "lat": lat};
}
