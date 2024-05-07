class WeatherModel {
  dynamic id;
  dynamic main;
  dynamic description;
  dynamic icon;
  WeatherModel({
    this.id,
    this.main,
    this.description,
    this.icon,
  });
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      id: json["id"],
      main: json["main"],
      description: json["description"],
      icon: json["icon"],
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
      };
}
