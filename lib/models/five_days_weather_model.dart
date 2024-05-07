import 'package:weaather_app/models/city_model.dart';
import 'package:weaather_app/models/weather_days_list_model.dart';

class FiveDaysWeatherModel {
  dynamic cod;
  dynamic message;
  dynamic cnt;
  List<WeatherDaysListModel>? list;
  CityModel? city;
  FiveDaysWeatherModel({
    this.cod,
    this.message,
    this.cnt,
    this.list,
    this.city,
  });
  factory FiveDaysWeatherModel.fromJson(Map<String, dynamic> json) {
    return FiveDaysWeatherModel(
      cod: json["cod"],
      message: json["message"],
      cnt: json["cnt"],
      list: List<WeatherDaysListModel>.from(json["list"] != null
          ? json["list"].map((x) => WeatherDaysListModel.fromJson(x))
          : []),
      city: CityModel.fromJson(json["city"]),
    );
  }
  Map<String, dynamic> toJson() => {
        "cod": cod,
        "message": message,
        "cnt": cnt,
        "list": list,
        "city": city,
      };
}
