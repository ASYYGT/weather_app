import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:weaather_app/data/five_day_weather_info_api.dart';
import 'package:weaather_app/models/day_weather_model.dart';
import 'package:weaather_app/models/five_days_weather_model.dart';
import 'package:weaather_app/models/path_city_model.dart';
import 'package:weaather_app/screens/search_city_weather/search_weather_page.dart';
import 'package:weaather_app/storage/context_extension.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:weaather_app/storage/date_controller.dart';
import 'package:weaather_app/storage/icon_controller.dart';
import 'package:weaather_app/storage/saved_cities_list.dart';
import 'package:weaather_app/widgets/custom_container.dart';
import 'package:weaather_app/widgets/custom_row_widget.dart';
import 'package:weather_icons/weather_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage(
      {super.key, required this.locationData, required this.dayWeatherModel});
  final LocationData locationData;
  final DayWeatherModel dayWeatherModel;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AnimationMixin {
  late AnimationController colorController;
  late Animation<Color?> color;
  late Animation<Color?> color1;
  late Animation<Color?> color2;
  FiveDaysWeatherModel? fiveDayInfoModel;

  DateTime now = DateTime.now();
  bool loadingScreen = true;
  Future<void> getWeatherInfo() async {
    if (widget.locationData.latitude.toString() != "null") {
      FiveDaysWeatherInfoApi.fiveDaysWeatherInfo(widget.locationData)
          .then((value) {
        setState(() {
          fiveDayInfoModel = value;
          loadingScreen = false;
        });
      });
    }
  }

  @override
  void initState() {
    getWeatherInfo();
    colorController = createController()
      ..mirror(duration: const Duration(seconds: 3));
    color =
        ColorTween(begin: const Color(0xFF0000FF), end: const Color(0xFF4682B4))
            .animate(colorController);
    color1 =
        ColorTween(begin: const Color(0xFF6A5ACD), end: const Color(0xFF800080))
            .animate(colorController);
    color2 =
        ColorTween(begin: const Color(0xFFEC6945), end: const Color(0xFF708090))
            .animate(colorController);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                "assets/images/${widget.dayWeatherModel.weather![0].icon}.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: loadingScreen
            ? Center(
                child: CircularProgressIndicator(
                  color: color2.value,
                ),
              )
            : Column(
                children: [
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: SizedBox(
                      height: context.dynamicHeight(0.15),
                      child: Row(children: [
                        IconButton(
                            onPressed: () {
                              CitiesPath.readCitiesList().then((value) {
                                if (value.isNotEmpty) {
                                  value.removeAt(0);
                                }
                                value.insert(
                                    0,
                                    PathCityModel(
                                      name: widget.dayWeatherModel.name,
                                      lat: widget.dayWeatherModel.coord!.lat,
                                      lon: widget.dayWeatherModel.coord!.lon,
                                    ));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          SearchCityWeatherPage(
                                              citiesList: value),
                                    ));
                              });
                            },
                            icon: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: context.middleIconSize,
                            ))
                      ]),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.pin_drop,
                        color: Colors.white,
                        size: context.middleIconSize,
                      ),
                      Text(
                        widget.dayWeatherModel.name.toString(),
                        maxLines: 2,
                        style: context.largeTextStyle(Colors.white),
                      ),
                    ],
                  ),
                  Text(
                    widget.dayWeatherModel.weather![0].description.toString(),
                    maxLines: 2,
                    style: context.largeTitleTextStyle(const Color(0xFFEC6945)),
                  ),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: context.dynamicHeight(0.02),
                                ),
                                customContainer(
                                  context,
                                  color.value!,
                                  color1.value!,
                                  termperatureContainer(),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: context.dynamicHeight(0.05),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(15)),
                              color: const Color(0xFF708090).withOpacity(0.5),
                            ),
                            width: context.dynamicWidth(1),
                            child: Column(
                              children: [
                                Container(
                                  padding:
                                      context.dynamicAllPadding(0.02, 0.03),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(15)),
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          const Color(0xFFEC6945),
                                          const Color(0xFF708090)
                                              .withOpacity(0.5)
                                        ]),
                                  ),
                                  child: weadherInfoRowWidget(),
                                ),
                                for (int i = 0; i < 8; i++)
                                  customContainer(
                                      context,
                                      color.value!,
                                      color1.value!,
                                      buildHourlyWeatherInfo(i, context)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget weadherInfoRowWidget() {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [buildWingContainer(), buildSunMovieContainer()],
          ),
        ),
        Expanded(
          child: buildWeatherInfoContainer(),
        ),
      ],
    );
  }

  Widget buildSunMovieContainer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(
                    widget.dayWeatherModel.sys!.sunrise * 1000)),
                textAlign: TextAlign.left,
                style: context.lowTextStyle(Colors.white),
              ),
            ),
            Expanded(
              child: BoxedIcon(
                WeatherIcons.sunrise,
                color: Colors.white,
                size: context.lowIconSize,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(
                    widget.dayWeatherModel.sys!.sunset * 1000)),
                textAlign: TextAlign.left,
                style: context.lowTextStyle(Colors.white),
              ),
            ),
            Expanded(
              child: BoxedIcon(
                WeatherIcons.sunset,
                color: Colors.white,
                size: context.lowIconSize,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildWeatherInfoContainer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomRowWidgets.customLowTextRowWidget(context, "Humidity",
            "${widget.dayWeatherModel.main!.humidity.toString()}%"),
        Divider(
          color: Colors.white.withOpacity(0.5),
        ),
        CustomRowWidgets.customLowTextRowWidget(context, "Real feel",
            "${double.parse(widget.dayWeatherModel.main!.feelsLike.toString()).round()}°"),
        Divider(
          color: Colors.white.withOpacity(0.5),
        ),
        CustomRowWidgets.customLowTextRowWidget(context, "Pressure",
            "${widget.dayWeatherModel.main!.pressure.toString()}mbar"),
        Divider(
          color: Colors.white.withOpacity(0.5),
        ),
        CustomRowWidgets.customLowTextRowWidget(context, "Visibility",
            "${(double.parse(widget.dayWeatherModel.visibility.toString()) / 1000).toStringAsFixed(2)}km"),
        Divider(
          color: Colors.white.withOpacity(0.5),
        ),
        CustomRowWidgets.customLowTextRowWidget(context, "Clouds",
            "${widget.dayWeatherModel.clouds!.all.toString()}%"),
      ],
    );
  }

  Widget buildWingContainer() {
    return Row(
      children: [
        Expanded(
          child: Text(
            "${widget.dayWeatherModel.wind!.speed.toString()}km/h\n${widget.dayWeatherModel.wind!.deg.toString()}°",
            textAlign: TextAlign.left,
            style: context.middleTextStyle(Colors.white),
          ),
        ),
        Expanded(
          child: BoxedIcon(
            IconController.wingIconController(
                double.parse(widget.dayWeatherModel.wind!.deg.toString())),
            color: Colors.white,
            size: context.middleIconSize2,
          ),
        ),
      ],
    );
  }

  Widget buildHourlyWeatherInfo(int index, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                DateController.stringTimeController(
                    fiveDayInfoModel!.list![index].dtTxt.toString()),
                style: context.middleTextStyle(Colors.white),
              ),
              Text(
                DateController.stringDateController(
                    fiveDayInfoModel!.list![index].dtTxt.toString()),
                textAlign: TextAlign.center,
                style: context.lowTextStyle(Colors.white),
              ),
            ],
          ),
        ),
        Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                    "https://openweathermap.org/img/wn/${fiveDayInfoModel!.list![index].weather![0].icon.toString()}@2x.png"),
                Text(
                  "${double.parse((fiveDayInfoModel!.list![index].main!.temp - 273.15).toString()).round()}°",
                  style: context.middleTextStyle(Colors.white),
                ),
              ],
            )),
        Expanded(
            flex: 2,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BoxedIcon(
                      WeatherIcons.rain,
                      color: Colors.white,
                      size: context.lowIconSize,
                    ),
                    Text(
                      "${(double.parse(fiveDayInfoModel!.list![index].pop.toString()) * 100).toStringAsFixed(1)}%",
                      style: context.middleTextStyle(Colors.white),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BoxedIcon(
                      WeatherIcons.windy,
                      color: Colors.white,
                      size: context.lowIconSize,
                    ),
                    Text(
                      "${double.parse(fiveDayInfoModel!.list![index].wind!.speed.toString()).toStringAsFixed(1)}km/h",
                      style: context.middleTextStyle(Colors.white),
                    ),
                  ],
                ),
              ],
            ))
      ],
    );
  }

  Widget termperatureContainer() {
    return Row(
      children: [
        Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${double.parse(widget.dayWeatherModel.main!.temp.toString()).round()}°",
                  style: context.bigTemperatureTextStyle(Colors.white),
                ),
                Text(
                  "${widget.dayWeatherModel.weather![0].main.toString()} ${double.parse(widget.dayWeatherModel.main!.tempMax.toString()).round()}°/${double.parse(widget.dayWeatherModel.main!.tempMin.toString()).round()}°",
                  style: context.middleTitleTextStyle(Colors.white),
                ),
              ]),
        ),
        Expanded(
            child: BoxedIcon(
          IconController.weatherIconController(
              widget.dayWeatherModel.weather![0].icon.toString()),
          color: color2.value,
          size: context.largeIconSize,
        ))
      ],
    );
  }
}
/**
Container(
                    padding: context.dynamicAllPadding(0.02, 0.02),
                    margin: context.dynamicVerticalPadding(0.05),
                    decoration: BoxDecoration(
                        color: context.clearSky[4].withOpacity(0.5),
                        borderRadius: context.borderRadiusValue),
                    width: context.dynamicWidth(0.8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.hot_tub_sharp,
                          size: context.middleIconSize,
                          color: Colors.white,
                        ),
                        Text(
                          "13°",
                          style: context.lowTextStyle(Colors.white),
                        ),
                        Icon(
                          Icons.pin_drop,
                          size: context.middleIconSize,
                          color: Colors.white,
                        ),
                        Text(
                          "%55",
                          style: context.lowTextStyle(Colors.white),
                        ),
                        Icon(
                          Icons.wind_power,
                          size: context.middleIconSize,
                          color: Colors.white,
                        ),
                        Text(
                          "2km/s",
                          style: context.lowTextStyle(Colors.white),
                        ),
                      ],
                    ),
                  )
                  ///////////////////////////////////
                  ///Expanded(
                                            flex: 2,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: BoxedIcon(
                                                        WeatherIcons.rain,
                                                        color: Colors.white,
                                                        size:
                                                            context.lowIconSize,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                        "%${item.pop.toString()}",
                                                        style: context
                                                            .middleTextStyle(
                                                                Colors.grey
                                                                    .shade300),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: context
                                                      .dynamicHeight(0.02),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: BoxedIcon(
                                                        WeatherIcons.wind,
                                                        color: Colors.white,
                                                        size:
                                                            context.lowIconSize,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                        "${item.wind!.speed}km/s",
                                                        style: context
                                                            .middleTextStyle(
                                                                Colors.grey
                                                                    .shade300),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
 */
