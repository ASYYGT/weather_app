import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:weaather_app/data/city_name_weather_info_api.dart';
import 'package:weaather_app/models/day_weather_model.dart';
import 'package:weaather_app/models/path_city_model.dart';
import 'package:weaather_app/storage/context_extension.dart';
import 'package:weaather_app/storage/saved_cities_list.dart';
import 'package:weaather_app/widgets/custom_container.dart';

class SearchCityWeatherPage extends StatefulWidget {
  const SearchCityWeatherPage({super.key, required this.citiesList});
  final List<PathCityModel> citiesList;
  @override
  State<SearchCityWeatherPage> createState() => _SearchCityWeatherPageState();
}

class _SearchCityWeatherPageState extends State<SearchCityWeatherPage>
    with AnimationMixin {
  List<DayWeatherModel> citiesWeatherInfo = [];
  bool showScreen = false;
  TextEditingController searchTextController = TextEditingController();
  bool isRemoveScreen = false;
  late AnimationController colorController;
  late Animation<Color?> color;
  late Animation<Color?> color1;
  late Animation<Color?> color2;
  Future<void> addCitiesInfoInList() async {
    for (var item in widget.citiesList) {
      await CityNameWeatherInfoApi.getWeatherInfoWithCityName(
              item.name.toString())
          .then((value) {
        citiesWeatherInfo.add(value);
      });
    }
  }

  Future<dynamic> loadingAlert(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: Colors.white,
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> addNewCity() async {
    loadingAlert(context);
    await CityNameWeatherInfoApi.getWeatherInfoWithCityName(
            searchTextController.text)
        .then((value) {
      Navigator.pop(context);
      searchTextController.clear();
      if (value.id != -1) {
        setState(() {
          citiesWeatherInfo.add(value);
          widget.citiesList.add(PathCityModel(
              name: value.name, lat: value.coord!.lat, lon: value.coord!.lon));
          CitiesPath.writeCitiesList(widget.citiesList);
        });
      } else {
        Fluttertoast.showToast(
            msg: "No Results",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }

  @override
  void initState() {
    addCitiesInfoInList().then((value) {
      setState(() {
        showScreen = true;
      });
    });
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isRemoveScreen = !isRemoveScreen;
                });
              },
              icon: const Icon(
                Icons.delete_forever,
              ))
        ],
      ),
      backgroundColor: Colors.white,
      body: showScreen
          ? Padding(
              padding: context.dynamicAllPadding(0.01, 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Manage cities",
                    style: context.largeTextStyle(Colors.black),
                  ),
                  TextField(
                    controller: searchTextController,
                    decoration: InputDecoration(
                      hintText: 'Enter city name',
                      suffixIconColor: color2.value,
                      suffixIcon: IconButton(
                        onPressed: () {
                          if (searchTextController.text.isNotEmpty) {
                            FocusScope.of(context).requestFocus(FocusNode());
                            addNewCity();
                          }
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ),
                    onSubmitted: (value) {
                      if (searchTextController.text.isNotEmpty) {
                        addNewCity();
                      }
                    },
                  ),
                  SizedBox(
                    height: context.dynamicHeight(0.02),
                  ),
                  Expanded(
                      child: ListView.builder(
                    itemCount: citiesWeatherInfo.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          customContainer(
                              context,
                              color.value!,
                              color1.value!,
                              buildHourlyWeatherInfo(
                                  citiesWeatherInfo[index], context)),
                          if (isRemoveScreen && index != 0)
                            Positioned(
                              top: 0.0,
                              right: 0.0,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    citiesWeatherInfo.removeAt(index);
                                    widget.citiesList.removeAt(index);
                                    CitiesPath.writeCitiesList(
                                        widget.citiesList);
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: color2.value,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ))
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            ),
    );
  }

  Widget buildHourlyWeatherInfo(DayWeatherModel item, BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${double.parse((item.main!.temp - 273.15).toString()).round()}°",
                    style: context.largeTextStyle(Colors.white),
                  ),
                  Text(
                    item.weather![0].description.toString(),
                    style: context.middleTextStyle(Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Align(
              alignment: Alignment.topRight,
              child: Image.network(
                  "https://openweathermap.org/img/wn/${item.weather![0].icon.toString()}@2x.png"),
            )),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "${item.name.toString()}, ${item.sys!.country.toString()}",
                style: context.middleTextStyle(Colors.white),
              ),
            ),
            Expanded(
              child: Text(
                "${double.parse((item.main!.tempMax - 273.15).toString()).round()}°/${double.parse((item.main!.tempMin - 273.15).toString()).round()}°",
                textAlign: TextAlign.end,
                style: context.middleTextStyle(Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
