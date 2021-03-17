import 'package:flutter/cupertino.dart';

class Weather extends ChangeNotifier {
  final String abbreviation;
  final String condition;
  final double currentTemperature;
  final int woeid;
  final String location;

  Weather({
    @required this.abbreviation,
    @required this.condition,
    @required this.currentTemperature,
    @required this.woeid,
    @required this.location,
  });
  String get temperatureInCelsius =>
      '${this.currentTemperature.round().toString()} °C';

  String get weatherCondition => this.condition;

  static Weather fromJson(dynamic json) {
    final consolidatedWeather = json['consolidated_weather'][0] != null
        ? json['consolidated_weather'][0]
        : null;
    if (consolidatedWeather == null) {
      throw Exception('Problem with weather API, try leter!');
    }
    return Weather(
      abbreviation: consolidatedWeather['weather_state_abbr'] as String,
      condition: consolidatedWeather["weather_state_name"]
              .replaceAll(' ', '')
              .toLowerCase() as String ??
          '',
      currentTemperature: consolidatedWeather['the_temp'] as double,
      woeid: json['woeid'] as int,
      location: json['title'] as String ?? '',
    );
  }
}
