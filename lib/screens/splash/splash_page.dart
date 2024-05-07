import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:weaather_app/data/weather_api.dart';
import 'package:weaather_app/models/day_weather_model.dart';
import 'package:weaather_app/screens/home/home_page.dart';
import 'package:weaather_app/storage/context_extension.dart';
import 'package:weaather_app/utils/location.dart';
import 'package:weather_icons/weather_icons.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with AnimationMixin {
  late AnimationController colorController;
  late Animation<Color?> color;
  late Animation<Color?> errorColor;
  LocationData? locationData;
  bool dataError = false;
  Future<void> getLocationData() async {
    try {
      locationData = await LocationHelper.getCurrentLocation();
      if (locationData != null) {
        WeatherApi.getCurrentTemperature(locationData).then((value) {
          setState(() {
            nextHomePage(value);
          });
        });
      } else {
        setState(() {
          dataError = true;
        });
      }
    } catch (e) {
      setState(() {
        getLocationData();
      });
    }
  }

  void nextHomePage(DayWeatherModel dayWeatherModel) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
              locationData: locationData!, dayWeatherModel: dayWeatherModel),
        ));
  }

  @override
  void initState() {
    getLocationData();
    colorController = createController()
      ..mirror(duration: const Duration(seconds: 3));
    color =
        ColorTween(begin: const Color(0xFFFFE74C), end: const Color(0xFFEC6945))
            .animate(colorController);
    errorColor =
        ColorTween(begin: const Color(0xFFD91E36), end: const Color(0xFFEB6F80))
            .animate(colorController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF800080), Color(0xFF4682B4)]),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              dataError
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          dataError = false;
                          getLocationData();
                        });
                      },
                      child: BoxedIcon(
                        WeatherIcons.refresh,
                        color: color.value,
                        size: context.largeIconSize,
                      ),
                    )
                  : BoxedIcon(
                      WeatherIcons.thermometer,
                      color: color.value,
                      size: context.largeIconSize,
                    ),
              if (dataError)
                Text(
                  "Please grant location permission for our app. Enable location access in your settings. Thank you!",
                  textAlign: TextAlign.center,
                  style: context.lowTextStyle(Colors.white),
                ),
              Text(
                "Weather-App",
                style: context.largeTextStyle(Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
