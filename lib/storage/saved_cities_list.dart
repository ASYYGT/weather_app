import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:weaather_app/models/path_city_model.dart';

class CitiesPath {
  static Future<List<PathCityModel>> readCitiesList() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    List<PathCityModel> citiesList;
    try {
      final file = File('$path/cities.txt');
      final cities = await file.readAsString();
      List jsonResponse = json.decode(cities);
      citiesList = jsonResponse.map((e) => PathCityModel.fromJson(e)).toList();
      return citiesList;
    } catch (e) {
      return [];
    }
  }

  static Future<File> writeCitiesList(List<PathCityModel> cities) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final file = File('$path/cities.txt');
    return file.writeAsString(
        json.encode(cities.map((e) => e.toJson()).toList()).toString());
  }
}
