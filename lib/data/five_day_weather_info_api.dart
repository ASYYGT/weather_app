import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:weaather_app/main.dart';
import 'package:weaather_app/models/five_days_weather_model.dart';

class FiveDaysWeatherInfoApi {
  static Future<FiveDaysWeatherModel> fiveDaysWeatherInfo(
      LocationData? locationData) async {
    FiveDaysWeatherModel newModel = FiveDaysWeatherModel();
    try {
      dynamic response = await http.get(Uri.parse(
          "http://api.openweathermap.org/data/2.5/forecast?lat=${locationData!.latitude}&lon=${locationData.longitude}&appid=$apiKey"));
      if (response.statusCode == 200) {
        newModel = FiveDaysWeatherModel.fromJson(json.decode(response.body));
      }
      return newModel;
    } catch (e) {
      return newModel;
    }
  }
}
