import 'package:weaather_app/models/clouds_model.dart';
import 'package:weaather_app/models/main_model.dart';
import 'package:weaather_app/models/weather_model.dart';
import 'package:weaather_app/models/wind_model.dart';

class WeatherDaysListModel {
  dynamic dt;
  MainModel? main;
  List<WeatherModel>? weather;
  CloudsModel? clouds;
  WindModel? wind;
  dynamic visibility;
  dynamic pop;
  dynamic dtTxt;
  WeatherDaysListModel({
    this.dt,
    this.main,
    this.weather,
    this.clouds,
    this.wind,
    this.visibility,
    this.pop,
    this.dtTxt,
  });
  factory WeatherDaysListModel.fromJson(Map<String, dynamic> json) {
    return WeatherDaysListModel(
      dt: json["dt"],
      main: MainModel.fromJson(json["main"]),
      weather: List<WeatherModel>.from(json["weather"] != null
          ? json["weather"].map((x) => WeatherModel.fromJson(x))
          : []),
      clouds: CloudsModel.fromJson(json["clouds"]),
      wind: WindModel.fromJson(json["wind"]),
      visibility: json["visibility"],
      pop: json["pop"],
      dtTxt: json["dt_txt"],
    );
  }
  Map<String, dynamic> toJson() => {
        "dt": dt,
        "main": main,
        "weather": weather,
        "clouds": clouds,
        "wind": wind,
        "visibility": visibility,
        "pop": pop,
        "dt_txt": dtTxt,
      };
}
