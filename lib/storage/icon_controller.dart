import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class IconController {
  static IconData wingIconController(double val) {
    IconData? iconData;
    if (val < 45) {
      iconData = WeatherIcons.wind_deg_0;
    } else if (val < 90) {
      iconData = WeatherIcons.wind_deg_45;
    } else if (val < 135) {
      iconData = WeatherIcons.wind_deg_90;
    } else if (val < 180) {
      iconData = WeatherIcons.wind_deg_135;
    } else if (val < 225) {
      iconData = WeatherIcons.wind_deg_180;
    } else if (val < 270) {
      iconData = WeatherIcons.wind_deg_225;
    } else if (val < 315) {
      iconData = WeatherIcons.wind_deg_270;
    } else {
      iconData = WeatherIcons.wind_deg_315;
    }
    return iconData;
  }

  static IconData weatherIconController(String val) {
    switch (val) {
      case "01d":
        return WeatherIcons.moon_alt_new;
      case "01n":
        return WeatherIcons.moon_alt_new;
      case "02d":
        return WeatherIcons.day_cloudy;
      case "02n":
        return WeatherIcons.night_alt_partly_cloudy;
      case "03d":
        return WeatherIcons.cloud;
      case "03n":
        return WeatherIcons.cloud;
      case "04d":
        return WeatherIcons.cloudy;
      case "04n":
        return WeatherIcons.cloudy;
      case "10d":
        return WeatherIcons.day_rain;
      case "10n":
        return WeatherIcons.night_alt_rain;
      case "11d":
        return WeatherIcons.thunderstorm;
      case "11n":
        return WeatherIcons.thunderstorm;
      case "13d":
        return WeatherIcons.snow_wind;
      case "13n":
        return WeatherIcons.snow_wind;
      case "50d":
        return WeatherIcons.fog;
      case "50n":
        return WeatherIcons.fog;
      default:
        return WeatherIcons.cloudy;
    }
  }
}
