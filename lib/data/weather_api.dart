import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:weaather_app/main.dart';
import 'package:weaather_app/models/day_weather_model.dart';

class WeatherApi {
  static Future<DayWeatherModel> getCurrentTemperature(
      LocationData? locationData) async {
    DayWeatherModel newModel = DayWeatherModel();
    try {
      dynamic response = await http.get(Uri.parse(
          "http://api.openweathermap.org/data/2.5/weather?lat=${locationData!.latitude}&lon=${locationData.longitude}&appid=$apiKey&units=metric"));
      if (response.statusCode == 200) {
        newModel = DayWeatherModel.fromJson(json.decode(response.body));
      }
      return newModel;
    } catch (e) {
      return newModel;
    }
  }
}
