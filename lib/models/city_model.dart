import 'package:weaather_app/models/coord_model.dart';

class CityModel {
  dynamic id;
  dynamic name;
  CoordModel? coord;
  dynamic country;
  dynamic population;
  dynamic timezone;
  dynamic sunrise;
  dynamic sunset;
  CityModel({
    this.id,
    this.name,
    this.coord,
    this.country,
    this.population,
    this.timezone,
    this.sunrise,
    this.sunset,
  });
  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json["id"],
      name: json["name"],
      coord: CoordModel.fromJson(json["coord"]),
      country: json["country"],
      population: json["population"],
      timezone: json["timezone"],
      sunrise: json["sunrise"],
      sunset: json["sunset"],
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "coord": coord,
        "country": country,
        "population": population,
        "timezone": timezone,
        "sunrise": sunrise,
        "sunset": sunset,
      };
}
