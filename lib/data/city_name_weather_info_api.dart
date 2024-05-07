import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weaather_app/main.dart';
import 'package:weaather_app/models/day_weather_model.dart';

class CityNameWeatherInfoApi {
  static Future<DayWeatherModel> getWeatherInfoWithCityName(
      String cityName) async {
    DayWeatherModel newModel = DayWeatherModel(id: -1);
    try {
      dynamic response = await http.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey"));
      if (response.statusCode == 200) {
        newModel = DayWeatherModel.fromJson(json.decode(response.body));
      }
      return newModel;
    } catch (e) {
      return newModel;
    }
  }
}
