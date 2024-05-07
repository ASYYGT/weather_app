import 'package:weaather_app/models/clouds_model.dart';
import 'package:weaather_app/models/coord_model.dart';
import 'package:weaather_app/models/main_model.dart';
import 'package:weaather_app/models/sys_model.dart';
import 'package:weaather_app/models/weather_model.dart';
import 'package:weaather_app/models/wind_model.dart';

class DayWeatherModel {
  CoordModel? coord;
  List<WeatherModel>? weather;
  dynamic base;
  MainModel? main;
  dynamic visibility;
  WindModel? wind;
  CloudsModel? clouds;
  dynamic dt;
  SysModel? sys;
  dynamic timezone;
  dynamic id;
  dynamic name;
  dynamic cod;
  DayWeatherModel({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });
  factory DayWeatherModel.fromJson(Map<String, dynamic> json) {
    return DayWeatherModel(
      coord: CoordModel.fromJson(json["coord"]),
      weather: List<WeatherModel>.from(json["weather"] != null
          ? json["weather"].map((x) => WeatherModel.fromJson(x))
          : []),
      base: json["base"],
      main: MainModel.fromJson(json["main"]),
      visibility: json["visibility"],
      wind: WindModel.fromJson(json["wind"]),
      clouds: CloudsModel.fromJson(json["clouds"]),
      dt: json["dt"],
      sys: SysModel.fromJson(json["sys"]),
      timezone: json["timezone"],
      id: json["id"],
      name: json["name"],
      cod: json["cod"],
    );
  }
  Map<String, dynamic> toJson() => {
        "coord": coord,
        "weather": weather,
        "base": base,
        "main": main,
        "visibility": visibility,
        "wind": wind,
        "clouds": clouds,
        "dt": dt,
        "sys": sys,
        "timezone": timezone,
        "id": id,
        "name": name,
        "cod": cod,
      };
}
